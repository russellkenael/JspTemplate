<%@ include file="../repositories/company_repository_impl.jsp" %>

<%!
class CompanyRepositoryTest {
    CompanyRepository repository;

    public CompanyRepositoryTest() {
        repository = new CompanyRepositoryImpl();
    }

    public void should_return_null_when_companies_not_found() {

        //System.out.println("- Testing getCompanyById...");
        Company companyById = repository.getCompanyById(-1);
        //System.out.println("- Testing getInvestedCompanyListByUserId...");
        List<Company> getInvestedCompanyListByUserId = repository.getInvestedCompanyListByUserId(-1);
        //System.out.println("- Testing getCompanyListByKeyword...");
        List<Company> getCompanyListByKeyword = repository.getCompanyListByKeyword("asdlfjhlvk");
        
        asserts(companyById == null && getInvestedCompanyListByUserId == null && getCompanyListByKeyword == null, "should_return_null_when_companies_not_found");
    }

    public void should_create_new_company_when_create_company_success() {

        Company company = new Company();
        company.owner = new User();
            company.owner.email = "jackyma@jd.id";
        company.name = "Alimama";
        company.description = "Alibaba spin-off";
        company.location = "Near alibaba";
        company.categoryName = "Tech";
        company.investmentStock = 100;
        company.investmentTarget = 1000000;
        company.investedAmount = 0;
        company.fulfilledPercentage = 0;
        company.image = "";
        company.email = "ali@mama.id";
        company.phone = "02242334233";
        company.url = "alimama.id";
        company.foundedYear = 2020;

        //System.out.println("Parameters set.");
        //System.out.println("Calling createCompany...");
        Company companyInserted = repository.createCompany(company);
        //System.out.println("Company created.");
        
        companyInserted.isCompleted = true;
        repository.updateCompany(companyInserted);
        
        //System.out.println("Calling getCompanyListByKeyword...");
        companyInserted = repository.getCompanyListByKeyword(company.name).get(0);
        //System.out.println("Company called");
        //System.out.println(companyInserted);

        asserts(companyInserted != null, "should_create_new_company_when_create_company");
    }

    public void should_change_email_when_update_company_success() {
        Company company = repository.getCompanyListByKeyword("Alimama").get(0);
        if(company == null) {
            should_create_new_company_when_create_company_success();
        }

        String oldEmail = company.email;
        company.email = "jd@mama.id";

        repository.updateCompany(company);
        
        company = repository.getCompanyListByKeyword("Alimama").get(0);

        String newEmail = company.email;

        company.email = oldEmail;
        repository.updateCompany(company);
        
        asserts(oldEmail != newEmail, "should_change_email_when_update_company_success");
    }

    public void should_delete_company_when_delete_company_success() {
        Company company = repository.getCompanyListByKeyword("Alimama").get(0);
        int companyId = company.id;

        repository.deleteCompany(companyId);

        company = repository.getCompanyById(companyId);

        asserts(company == null, "should_delete_company_when_delete_company_success");
    }
}
%>