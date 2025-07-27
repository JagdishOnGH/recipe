import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import '../features/online_recipe/models/recipe_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'recipes.db');
    
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE recipes (
        id INTEGER PRIMARY KEY,
        name TEXT NOT NULL,
        image TEXT,
        rating REAL,
        reviewCount INTEGER,
        userId INTEGER,
        difficulty TEXT,
        cuisine TEXT,
        caloriesPerServing INTEGER,
        prepTimeMinutes INTEGER,
        cookTimeMinutes INTEGER,
        servings INTEGER,
        ingredients TEXT, -- JSON string
        instructions TEXT, -- JSON string
        tags TEXT, -- JSON string
        mealType TEXT, -- JSON string
        createdAt INTEGER,
        updatedAt INTEGER
      )
    ''');

    await db.execute('''
      CREATE INDEX idx_recipes_name ON recipes(name);
    ''');

    await db.execute('''
      CREATE INDEX idx_recipes_cuisine ON recipes(cuisine);
    ''');

    await db.execute('''
      CREATE INDEX idx_recipes_rating ON recipes(rating);
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Handle database migrations here
    if (oldVersion < 2) {
      // Example migration for version 2
      // await db.execute('ALTER TABLE recipes ADD COLUMN new_column TEXT');
    }
  }

  Future<void> insertRecipe(Recipe recipe) async {
    final db = await database;
    await db.insert(
      'recipes',
      _recipeToMap(recipe),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Recipe?> getRecipe(int id) async {
    final db = await database;
    final maps = await db.query(
      'recipes',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return _mapToRecipe(maps.first);
    }
    return null;
  }

  Future<List<Recipe>> getAllRecipes({
    int? limit,
    int? offset,
    String? searchQuery,
    String? cuisine,
  }) async {
    final db = await database;
    String whereClause = '';
    List<dynamic> whereArgs = [];

    if (searchQuery != null && searchQuery.isNotEmpty) {
      whereClause = 'name LIKE ?';
      whereArgs.add('%$searchQuery%');
    }

    if (cuisine != null && cuisine.isNotEmpty) {
      if (whereClause.isNotEmpty) whereClause += ' AND ';
      whereClause += 'cuisine = ?';
      whereArgs.add(cuisine);
    }

    final maps = await db.query(
      'recipes',
      where: whereClause.isEmpty ? null : whereClause,
      whereArgs: whereArgs.isEmpty ? null : whereArgs,
      orderBy: 'rating DESC',
      limit: limit,
      offset: offset,
    );

    return maps.map((map) => _mapToRecipe(map)).toList();
  }

  Future<bool> hasRecipe(int id) async {
    final db = await database;
    final result = await db.query(
      'recipes',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );
    return result.isNotEmpty;
  }

  Future<void> deleteRecipe(int id) async {
    final db = await database;
    await db.delete(
      'recipes',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> getRecipeCount() async {
    final db = await database;
    final result = await db.rawQuery('SELECT COUNT(*) FROM recipes');
    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<void> clearAllRecipes() async {
    final db = await database;
    await db.delete('recipes');
  }

  Map<String, dynamic> _recipeToMap(Recipe recipe) {
    return {
      'id': recipe.id,
      'name': recipe.name,
      'image': recipe.image,
      'rating': recipe.rating,
      'reviewCount': recipe.reviewCount,
      'userId': recipe.userId,
      'difficulty': recipe.difficulty,
      'cuisine': recipe.cuisine,
      'caloriesPerServing': recipe.caloriesPerServing,
      'prepTimeMinutes': recipe.prepTimeMinutes,
      'cookTimeMinutes': recipe.cookTimeMinutes,
      'servings': recipe.servings,
      'ingredients': recipe.ingredients?.join(','),
      'instructions': recipe.instructions?.split('|').join('|'),
      'tags': recipe.tags?.join(','),
      'mealType': recipe.mealType?.join(','),
      'createdAt': DateTime.now().millisecondsSinceEpoch,
      'updatedAt': DateTime.now().millisecondsSinceEpoch,
    };
  }

  Recipe _mapToRecipe(Map<String, dynamic> map) {
    return Recipe(
      id: map['id'],
      name: map['name'],
      image: map['image'],
      rating: map['rating']?.toDouble(),
      reviewCount: map['reviewCount'],
      userId: map['userId'],
      difficulty: map['difficulty'],
      cuisine: map['cuisine'],
      caloriesPerServing: map['caloriesPerServing'],
      prepTimeMinutes: map['prepTimeMinutes'],
      cookTimeMinutes: map['cookTimeMinutes'],
      servings: map['servings'],
      ingredients: map['ingredients']?.split(',').where((s) => s.isNotEmpty).toList(),
      instructions: map['instructions']?.split('|').where((s) => s.isNotEmpty).toList(),
      tags: map['tags']?.split(',').where((s) => s.isNotEmpty).toList(),
      mealType: map['mealType']?.split(',').where((s) => s.isNotEmpty).toList(),
    );
  }
}