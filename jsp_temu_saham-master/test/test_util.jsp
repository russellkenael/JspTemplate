<%!
public void asserts(boolean condition, String caseName) {
    if(condition) {
        System.out.println("+ " + caseName + " OK.");
    } else {
        System.out.println("+ " + caseName + " FAILED.");
    }
}
    
%>