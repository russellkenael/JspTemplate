<%!
class App {
    public App() {
        ExampleRepository repository = new ExampleRepository(new ExampleDbInstance());
        ArrayList<ExampleModel> exampleList = repository.getExamples();
        for(ExampleModel m : exampleList) {
            System.out.println(m.title);
            System.out.println("==============");
            System.out.println(m.content);
            System.out.println();
        }
    }

    public static void main(String[] args) {
        new App();
    }
}
%>