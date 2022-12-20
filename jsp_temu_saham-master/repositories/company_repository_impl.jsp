<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>

<%@ page import="java.sql.SQLException" %>

<%@ page import="javax.sql.RowSet" %>
<%@ page import="javax.sql.rowset.CachedRowSet" %>
<%@ page import="javax.sql.rowset.RowSetProvider" %>

<%@ include file="../models/Company.jsp" %>
<%@ include file="company_repository.jsp" %>

<%!
class CompanyRepositoryImpl implements CompanyRepository {
    
    @Override
    public Company getCompanyById(int id) {
        String query = "" +
        "SELECT c.id" +
        "     , u.name                          AS ownerName" +
        "     , u.email                         AS ownerEmail" +
        "     , c.name" +
        "     , c.description" +
        "     , c.location" +
        "     , ca.name                         AS categoryName" +
        "     , c.investment_stock              AS investmentStock" +
        "     , c.investment_target             AS investmentTarget" +
        "     , COALESCE(SUM(i.amount), 0)      AS investedAmount" +
        "     , COALESCE(SUM(i.percentage), 0)  AS fulfilledPercentage" +
        "     , c.image" +
        "     , c.email" +
        "     , c.phone" +
        "     , c.url" +
        "     , c.founded_year                  AS foundedYear" +
        "     , c.is_invested                   AS isInvested" +
        "     , c.is_completed                  AS isCompleted" +
        "  FROM Companies c" +
        "       LEFT JOIN Investments i" +
        "       ON   i.company_id = c.id" +
        "       " +
        "       JOIN Categories ca" +
        "       ON   ca.id = c.category_id" +
        "       " +
        "       JOIN Users u" +
        "       ON  u.id = c.user_id" +
        " WHERE c.id = ?" +
        " GROUP BY c.id" +
        "     , u.name" +
        "     , u.email" +
        "     , c.name" +
        "     , c.description" +
        "     , c.location" +
        "     , ca.name" +
        "     , c.investment_stock" +
        "     , c.investment_target" +
        "     , c.image" +
        "     , c.email" +
        "     , c.phone" +
        "     , c.url" +
        "     , c.founded_year" +
        "     , c.is_invested" +
        "     , c.is_completed";

        Object[] parameters = new Object[] { id };

        RowSet rowSet = TemuSahamDbInstance.executeQuery(query, parameters);

        Company company = new Company();
        User user = new User();
        try {
            rowSet.beforeFirst();
            while(rowSet.next()) {
                company.id = rowSet.getInt(1);
                user.name = rowSet.getString(2);
                user.email = rowSet.getString(3);
                company.owner = user;
                company.name = rowSet.getString(4);
                company.description = rowSet.getString(5);
                company.location = rowSet.getString(6);
                company.categoryName = rowSet.getString(7);
                company.investmentStock = rowSet.getInt(8);
                company.investmentTarget = rowSet.getLong(9);
                company.investedAmount = rowSet.getLong(10);
                company.fulfilledPercentage = rowSet.getFloat(11);
                company.image = rowSet.getString(12);
                company.email = rowSet.getString(13);
                company.phone = rowSet.getString(14);
                company.url = rowSet.getString(15);
                company.foundedYear = Integer.valueOf(rowSet.getString(16));
                company.isInvested = rowSet.getString(17).charAt(0) == 'Y' ? true : false;
                company.isCompleted = rowSet.getString(18).charAt(0) == 'Y' ? true : false;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                rowSet.close();
                rowSet = null;
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return company.id != 0 ? company : null;
    }

    @Override
    public Company getCompanyByUserEmail(String userEmail) {
        String query = "" +
        "SELECT c.id" +
        "     , u.name                          AS ownerName" +
        "     , u.email                         AS ownerEmail" +
        "     , c.name" +
        "     , c.description" +
        "     , c.location" +
        "     , ca.name                         AS categoryName" +
        "     , c.investment_stock              AS investmentStock" +
        "     , c.investment_target             AS investmentTarget" +
        "     , COALESCE(SUM(i.amount), 0)      AS investedAmount" +
        "     , COALESCE(SUM(i.percentage), 0)  AS fulfilledPercentage" +
        "     , c.image" +
        "     , c.email" +
        "     , c.phone" +
        "     , c.url" +
        "     , c.founded_year                  AS foundedYear" +
        "     , c.is_invested                   AS isInvested" +
        "     , c.is_completed                  AS isCompleted" +
        "  FROM Companies c" +
        "       LEFT JOIN Investments i" +
        "       ON   i.company_id = c.id" +
        "       " +
        "       JOIN Categories ca" +
        "       ON   ca.id = c.category_id" +
        "       " +
        "       JOIN Users u" +
        "       ON  u.id = c.user_id" +
        " WHERE u.email = ?" +
        " GROUP BY c.id" +
        "     , u.name" +
        "     , u.email" +
        "     , c.name" +
        "     , c.description" +
        "     , c.location" +
        "     , ca.name" +
        "     , c.investment_stock" +
        "     , c.investment_target" +
        "     , c.image" +
        "     , c.email" +
        "     , c.phone" +
        "     , c.url" +
        "     , c.founded_year" +
        "     , c.is_invested" +
        "     , c.is_completed";

        Object[] parameters = new Object[] { userEmail };

        //System.out.println(userEmail);
        RowSet rowSet = TemuSahamDbInstance.executeQuery(query, parameters);
        //System.out.println("Passed");

        Company company = new Company();
        User user = new User();
        try {
            rowSet.beforeFirst();
            while(rowSet.next()) {
                company.id = rowSet.getInt(1);
                user.name = rowSet.getString(2);
                user.email = rowSet.getString(3);
                company.owner = user;
                company.name = rowSet.getString(4);
                company.description = rowSet.getString(5);
                company.location = rowSet.getString(6);
                company.categoryName = rowSet.getString(7);
                company.investmentStock = rowSet.getInt(8);
                company.investmentTarget = rowSet.getLong(9);
                company.investedAmount = rowSet.getLong(10);
                company.fulfilledPercentage = rowSet.getFloat(11);
                company.image = rowSet.getString(12);
                company.email = rowSet.getString(13);
                company.phone = rowSet.getString(14);
                company.url = rowSet.getString(15);
                company.foundedYear = Integer.valueOf(rowSet.getString(16));
                company.isInvested = rowSet.getString(17).charAt(0) == 'Y' ? true : false;
                company.isCompleted = rowSet.getString(18).charAt(0) == 'Y' ? true : false;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                rowSet.close();
                rowSet = null;
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        //System.out.println(company);
        return company.id != 0 ? company : null;
    }
    
    @Override
    public List<Company> getInvestedCompanyListByUserId(int userId) {
        String query = "" +
        "SELECT c.id" +
        "     , u.name                          AS ownerName" +
        "     , u.email                         AS ownerEmail" +
        "     , c.name" +
        "     , c.description" +
        "     , c.location" +
        "     , ca.name                         AS categoryName" +
        "     , c.investment_stock              AS investmentStock" +
        "     , c.investment_target             AS investmentTarget" +
        "     , COALESCE(SUM(i.amount), 0)      AS investedAmount" +
        "     , COALESCE(SUM(i.percentage), 0)  AS fulfilledPercentage" +
        "     , c.image" +
        "     , c.email" +
        "     , c.phone" +
        "     , c.url" +
        "     , c.founded_year                  AS foundedYear" +
        "     , c.is_invested                   AS isInvested" +
        "     , c.is_completed                  AS isCompleted" +
        "  FROM Companies c" +
        "       LEFT JOIN Investments i" +
        "       ON   i.company_id = c.id" +
        "       " +
        "       JOIN Categories ca" +
        "       ON   ca.id = c.category_id" +
        "       " +
        "       JOIN Users u" +
        "       ON  u.id = c.user_id" +
        " WHERE u.id = ?" +
        " GROUP BY c.id" +
        "     , u.name" +
        "     , u.email" +
        "     , c.name" +
        "     , c.description" +
        "     , c.location" +
        "     , ca.name" +
        "     , c.investment_stock" +
        "     , c.investment_target" +
        "     , c.image" +
        "     , c.email" +
        "     , c.phone" +
        "     , c.url" +
        "     , c.founded_year" +
        "     , c.is_invested" +
        "     , c.is_completed";

        Object[] parameters = new Object[] { userId };
        
        RowSet rowSet = TemuSahamDbInstance.executeQuery(query, parameters);

        List<Company> companyList = new ArrayList<>();

        try {
            rowSet.beforeFirst();
            while(rowSet.next()) {
                Company company = new Company();
                User user = new User();

                company.id = rowSet.getInt(1);
                user.name = rowSet.getString(2);
                user.email = rowSet.getString(3);
                company.owner = user;
                company.name = rowSet.getString(4);
                company.description = rowSet.getString(5);
                company.location = rowSet.getString(6);
                company.categoryName = rowSet.getString(7);
                company.investmentStock = rowSet.getInt(8);
                company.investmentTarget = rowSet.getLong(9);
                company.investedAmount = rowSet.getLong(10);
                company.fulfilledPercentage = rowSet.getFloat(11);
                company.image = rowSet.getString(12);
                company.email = rowSet.getString(13);
                company.phone = rowSet.getString(14);
                company.url = rowSet.getString(15);
                company.foundedYear = Integer.valueOf(rowSet.getString(16));
                company.isInvested = rowSet.getString(17).charAt(0) == 'Y' ? true : false;
                company.isCompleted = rowSet.getString(18).charAt(0) == 'Y' ? true : false;

                companyList.add(company);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                rowSet.close();
                rowSet = null;
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return companyList.size() != 0 ? companyList : null;
    }
    
    @Override
    public List<Company> getCompanyListByKeyword(String keyword) {
        String query = "" +
        "SELECT c.id" +
        "     , u.name                          AS ownerName" +
        "     , u.email                         AS ownerEmail" +
        "     , c.name" +
        "     , c.description" +
        "     , c.location" +
        "     , ca.name                         AS categoryName" +
        "     , c.investment_stock              AS investmentStock" +
        "     , c.investment_target             AS investmentTarget" +
        "     , COALESCE(SUM(i.amount), 0)      AS investedAmount" +
        "     , COALESCE(SUM(i.percentage), 0)  AS fulfilledPercentage" +
        "     , c.image" +
        "     , c.email" +
        "     , c.phone" +
        "     , c.url" +
        "     , c.founded_year                  AS foundedYear" +
        "     , c.is_invested                   AS isInvested" +
        "     , c.is_completed                  AS isCompleted" +
        "  FROM Companies c" +
        "       LEFT JOIN Investments i" +
        "       ON   i.company_id = c.id" +
        "       " +
        "       JOIN Categories ca" +
        "       ON   ca.id = c.category_id" +
        "       " +
        "       JOIN Users u" +
        "       ON  u.id = c.user_id" +
        " WHERE is_completed = 'Y' " +
        "   AND UPPER(c.name) LIKE UPPER(?) " +
        " GROUP BY c.id" +
        "     , u.name" +
        "     , u.email" +
        "     , c.name" +
        "     , c.description" +
        "     , c.location" +
        "     , ca.name" +
        "     , c.investment_stock" +
        "     , c.investment_target" +
        "     , c.image" +
        "     , c.email" +
        "     , c.phone" +
        "     , c.url" +
        "     , c.founded_year" +
        "     , c.is_invested" +
        "     , c.is_completed";

        Object[] parameters = new Object[] { "%" + keyword + "%"};

        RowSet rowSet = TemuSahamDbInstance.executeQuery(query, parameters);

        List<Company> companyList = new ArrayList<>();

        try {
            rowSet.beforeFirst();
            while(rowSet.next()) {
                Company company = new Company();
                User user = new User();
                
                company.id = rowSet.getInt(1);
                user.name = rowSet.getString(2);
                user.email = rowSet.getString(3);
                company.owner = user;
                company.name = rowSet.getString(4);
                company.description = rowSet.getString(5);
                company.location = rowSet.getString(6);
                company.categoryName = rowSet.getString(7);
                company.investmentStock = rowSet.getInt(8);
                company.investmentTarget = rowSet.getLong(9);
                company.investedAmount = rowSet.getLong(10);
                company.fulfilledPercentage = rowSet.getFloat(11);
                company.image = rowSet.getString(12);
                company.email = rowSet.getString(13);
                company.phone = rowSet.getString(14);
                company.url = rowSet.getString(15);
                company.foundedYear = Integer.valueOf(rowSet.getString(16));
                company.isInvested = rowSet.getString(17).charAt(0) == 'Y' ? true : false;
                company.isCompleted = rowSet.getString(18).charAt(0) == 'Y' ? true : false;

                companyList.add(company);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                rowSet.close();
                rowSet = null;
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        // System.out.println("Returning...");
        // System.out.println(companyList.size());
        return companyList.size() != 0 ? companyList : null;
    }

    @Override
    public boolean updateCompanyFullByUserId(Company company) {
        String query = "" +
        "UPDATE Companies c " +
        "   SET c.category_id = ? " +
        "     , c.name = ? " +
        "     , c.description = IFNULL(?, description)" +
        "     , c.location = IFNULL(?, location)" +
        "     , c.investment_stock = IFNULL(?, investment_stock)" +
        "     , c.investment_target = IFNULL(?, investment_target)" +
        "     , c.image = IFNULL(?, image)" +
        "     , c.email = IFNULL(?, email)" +
        "     , c.phone = IFNULL(?, phone)" +
        "     , c.url = IFNULL(?, url)" +
        "     , c.founded_year = IFNULL(?, founded_year)" +
        "     , c.is_completed = IFNULL(?, is_completed)" +
        " WHERE c.user_id = ?";

        Object[] parameters = new Object[] {
            company.categoryId,
            company.name,
            company.description,
            company.location,
            company.investmentStock,
            company.investmentTarget,
            company.image,
            company.email,
            company.phone,
            company.url,
            company.foundedYear,
            company.isCompleted ? "Y" : "N",
            company.owner.id
        };
        
        TemuSahamDbInstance.executeQuery(query, parameters);
        return true;
    }

    @Override
    public boolean updateIsInvested(int companyId, boolean isInvested) {
        String query = "" +
        "UPDATE Companies c " +
        "   SET c.is_invested = ?" +
        " WHERE c.id = ?";

        Object[] parameters = new Object[] {
            isInvested ? "Y" : "N",
            companyId
        };
        
        TemuSahamDbInstance.executeQuery(query, parameters);
        return true;
    }
    
    @Override
    public boolean updateCompany(Company company) {
        String query = "" +
        "UPDATE Companies c " +
        "   SET c.description = IFNULL(?, description)" +
        "     , c.email = IFNULL(?, email)" +
        "     , c.phone = IFNULL(?, phone)" +
        "     , c.url = IFNULL(?, url)" +
        " WHERE c.id = ?";

        Object[] parameters = new Object[] {
            company.description,
            company.email,
            company.phone,
            company.url,
            company.id
        };
        
        TemuSahamDbInstance.executeQuery(query, parameters);
        return true;
    }

    @Override
    public boolean deleteCompany(int userId) {
        String query = "" +
        "DELETE FROM Companies " +
        " WHERE user_id = ? " +
        "   AND is_invested = 'N'";

        Object[] parameters = new Object[] { userId };

        TemuSahamDbInstance.executeQuery(query, parameters);

        query = "" +
        "UPDATE Users " +
        "   SET type = ? " +
        " WHERE id = ? ";

        parameters = new Object[] { "investor", userId };

        TemuSahamDbInstance.executeQuery(query, parameters);
        return true;
    }

    @Override
    public Company createCompany(Company company) {
        String query = "" +
        "INSERT INTO Companies (user_id, category_id, name, description, location, investment_stock, investment_target, image, email, phone, url, founded_year)" +
        "SELECT u.id, c.id, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? " +
        "  FROM Users u, Categories c " +
        " WHERE u.email = ? AND c.name = IFNULL(? , c.name)";

        Object[] parameters = new Object[] {
            company.name,
            company.description,
            company.location,
            company.investmentStock,
            company.investmentTarget,
            company.image,
            company.email,
            company.phone,
            company.url,
            company.foundedYear,
            company.owner.email,
            company.categoryName
        };

        TemuSahamDbInstance.executeQuery(query, parameters);
        
        Company result = getCompanyByUserEmail(company.owner.email);
        //System.out.println("Hello");
        
        return result;
    }

    @Override
    public Company createCompanyKosongan(Company company) {
        String query = "" +
        "INSERT INTO Companies (user_id)" +
        "SELECT u.id" +
        "  FROM Users u" +
        " WHERE u.email = ?";

        Object[] parameters = new Object[] {
            company.owner.email,
        };

        TemuSahamDbInstance.executeQuery(query, parameters);

        Company result = getCompanyByUserEmail(company.owner.email);
        //System.out.println("Hello");
        
        return result;
    }
}
%>