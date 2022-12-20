<%!
class ExampleDbInstance extends DbInstance {

    public ExampleDbInstance() { // All you need to do is set the config and set the entities.
        this.config = DbConfig.getConfig("ExampleDb");
        
        this.entities = new ArrayList<Class<Entity>>();
        this.entities.add(CartEntity.class);
        this.entities.add(TransactionEntity.class);
        this.entities.add(UserEntity.class);
    }
}
%>