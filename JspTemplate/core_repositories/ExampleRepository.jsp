<%!
class ExampleRepository extends Repository {

    private ExampleAdapter adapter;
    public ExampleRepository(DbInstance db) { // The ExampleAdapter can be Injected (See https://en.wikipedia.org/wiki/Dependency_injection on "Contructor injection")
        this.db = db;
        this.adapter = new ExampleAdapter();
    }

    // Using implicit properties. (the property `query`, `parameters`, and `result`) (See `Repository.jsp`)
    public List<ExampleModel> getExamplesByKeyword(String keyword, String keywordType) {
        query = "" +
            "SELECT f.Id, fc.Name AS Category, f.Name, f.Description, f.Price, f.ImageUrl, f.StockQuantity " +
            "  FROM Food f " +
            "       JOIN FoodCategory fc " +
            "       ON   fc.Id = f.FoodCategoryId " +
            "";

        if(keywordType.toLowerCase() == "name") {
            query += " WHERE f.Name LIKE ? ";
        } else if (keywordType.toLowerCase() == "description") {
            query += " WHERE f.Description LIKE ? ";
        } else if (keywordType.toLowerCase() == "category") {
            query += " WHERE fc.Name LIKE ? ";
        }

        parameters = new Object[] { "%" + keyword + "%" };
        
        result = db.executeQuery(query, parameters);

        return adapter.adaptMany(result);
    }

    // Without implicit properties.
    public List<ExampleModel> getExamples() {
        return adapter.adaptMany(
            db.executeQuery(
                "SELECT f.Id, fc.Name AS Category, f.Name, f.Description, f.Price, f.ImageUrl, f.StockQuantity " +
                " FROM Food f " +
                "      JOIN FoodCategory fc " +
                "      ON   fc.Id = f.FoodCategoryId " +
                " " +
                "      JOIN User u " +
                "      ON   u.Id = f.CreatorId " +
                "WHERE u.Id = ? "
                , new Object[] { userId };
            );
        );
    }
}
%>