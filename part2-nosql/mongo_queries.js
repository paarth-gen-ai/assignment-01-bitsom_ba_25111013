// Part 2.2: MongoDB Operations
// E-Commerce Product Catalog
// Student ID: bitsom_ba_25111013

// ============================================
// OP1: insertMany() - Insert all 3 documents from sample_documents.json
// ============================================
db.products.insertMany([
  {
    "_id": "ELEC001",
    "category": "Electronics",
    "name": "Wireless Noise-Cancelling Headphones",
    "brand": "SoundMax",
    "price": 24999,
    "stock_quantity": 150,
    "specifications": {
      "bluetooth_version": "5.2",
      "battery_life_hours": 30,
      "noise_cancellation": "Active",
      "voltage": "5V",
      "warranty_years": 2
    },
    "features": ["Active Noise Cancellation", "Voice Assistant", "Foldable Design"],
    "reviews": [
      {"user": "Rajesh_K", "rating": 5, "comment": "Excellent sound quality"},
      {"user": "Priya_M", "rating": 4, "comment": "Great headphones"}
    ],
    "seller": {"id": "SEL001", "name": "TechStore India", "rating": 4.7}
  },
  {
    "_id": "CLTH001",
    "category": "Clothing",
    "name": "Men's Cotton Formal Shirt",
    "brand": "UrbanThreads",
    "price": 1499,
    "stock_quantity": 500,
    "specifications": {
      "material": "100% Cotton",
      "fit": "Slim Fit",
      "sleeve_length": "Full Sleeve",
      "collar_type": "Spread Collar"
    },
    "sizes_available": ["S", "M", "L", "XL", "XXL"],
    "colors_available": ["White", "Light Blue", "Navy", "Black"],
    "reviews": [
      {"user": "Amit_S", "rating": 5, "comment": "Perfect fit"}
    ],
    "seller": {"id": "SEL002", "name": "Fashion Hub", "rating": 4.5}
  },
  {
    "_id": "GROC001",
    "category": "Groceries",
    "name": "Organic Brown Rice",
    "brand": "NatureHarvest",
    "price": 180,
    "stock_quantity": 2000,
    "specifications": {
      "grain_type": "Long Grain",
      "processing": "Organic",
      "origin": "West Bengal, India"
    },
    "nutritional_info": {
      "calories_per_100g": 350,
      "protein_g": 7.5,
      "carbohydrates_g": 76,
      "fat_g": 2.5,
      "fiber_g": 3.2
    },
    "expiry_date": new Date("2025-08-15"),
    "batch_number": "BH2025A1234",
    "certifications": ["India Organic", "FSSAI Approved"],
    "reviews": [
      {"user": "Sneha_R", "rating": 5, "comment": "Fresh and great quality"}
    ],
    "seller": {"id": "SEL003", "name": "Green Basket", "rating": 4.8}
  }
]);

// ============================================
// OP2: find() - Retrieve all Electronics products with price > 20000
// ============================================
db.products.find({
  category: "Electronics",
  price: { $gt: 20000 }
});

// ============================================
// OP3: find() - Retrieve all Groceries expiring before 2025-01-01
// ============================================
db.products.find({
  category: "Groceries",
  expiry_date: { $lt: new Date("2025-01-01") }
});

// ============================================
// OP4: updateOne() - Add a "discount_percent" field to a specific product
// ============================================
db.products.updateOne(
  { _id: "ELEC001" },
  { $set: { discount_percent: 15 } }
);

// ============================================
// OP5: createIndex() - Create an index on category field
// Explanation:
// An index on the 'category' field is created because:
// 1. Category is frequently used in WHERE clauses for filtering products
//    (e.g., showing only Electronics, Clothing, or Groceries)
// 2. Without an index, MongoDB would perform a full collection scan (COLLSCAN)
//    which is O(n) - inefficient for large collections
// 3. With an index, MongoDB can use the index to quickly locate matching
//    documents, reducing query time to O(log n)
// 4. The 'category' field has low cardinality (only 3 unique values), so
//    a simple index provides significant performance improvement
// 5. This index also benefits aggregation pipelines that group by category
// ============================================
db.products.createIndex({ category: 1 });

// Verify the index was created
db.products.getIndexes();
