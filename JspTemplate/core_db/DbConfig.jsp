<%@ page import="java.util.HashMap;" %>
<%@ page import="java.util.Map;" %>

<%!
class DbConfig {
    private static Map<String, Map<String, String>> configs;

    // Only this part that needs to be changed
    private static void initConfig() {
        configs = new HashMap<>();
        configs.put("ExampleDb", createDbProperties(
                "com.mysql.cj.jdbc.Driver",
                "jdbc:mysql://localhost:3306/",
                "ExampleDb",
                "root",
                ""));
    } //

    // From here to the end only for automation/syntactic sugar.
    public static Map<String, Map<String, String>> getConfigs() {
        if (configs == null) { initConfig(); }

        return configs;
    }

    public static Map<String, String> getConfig(String configKey) {
        if (configs == null) { initConfig(); }

        return configs.get(configKey);
    }

    private static Map<String, String> createDbProperties(String driver, String url, String name, String user,
            String password) {
        Map<String, String> properties = new HashMap<>();
        properties.put("driver", driver);
        properties.put("url", url);
        properties.put("name", name);
        properties.put("user", user);
        properties.put("password", password);

        return properties;
    }
}
%>