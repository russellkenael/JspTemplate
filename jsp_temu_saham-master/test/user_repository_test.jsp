<%@ include file="../repositories/user_repository_impl.jsp" %>

<%!
class UserRepositoryTest {
    UserRepository repository;

    public UserRepositoryTest() {
        repository = new UserRepositoryImpl();
    }

    public void should_return_null_when_user_not_found() {
        User userById = repository.getUserById(-1);
        User userByEmail = repository.getUserByEmail("johndont@gmail.com");

        asserts(userById == null && userByEmail == null, "should_return_null_when_user_not_found");
    }

    public void should_return_new_user_when_add_user_success() {
        User user = new User();
        user.name = "Jacky Ma";
        user.type = "Investor";
        user.email = "jackyma@jd.id";
        user.password = "alimamaaintelligence";

        repository.addUser(user);

        user = repository.getUserByEmail("jackyma@jd.id");
        
        asserts(user != null, "should_return_new_user_when_add_user_success");
    }

    public void should_change_password_when_update_user_success() {
        User user = repository.getUserByEmail("jackyma@jd.id");
        if(user == null) {
            should_return_new_user_when_add_user_success();
        }
        String oldPassword = user.password;
        
        user.password = "notartificialintelligence";

        repository.updateUser(user);

        user = repository.getUserByEmail("jackyma@jd.id");

        String newPassword = user.password;

        user.password = oldPassword;
        repository.updateUser(user);

        asserts(oldPassword != newPassword, "should_change_password_when_update_user_success");
    }
}
%>