using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Services;

[WebService(Namespace = "apress:examples:webservices")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class Service : System.Web.Services.WebService
{
    public Service()
    {
        //InitializeComponent(); 
    }

    [WebMethod]
    public DataSet AdvPersonSearch(string LastName)
    {
        string sqlconnection = "SERVER=SQL2008;" +
          "INITIAL CATALOG=AdventureWorks;" +
          "INTEGRATED SECURITY=SSPI;";

        DataSet result = new DataSet();
        SqlDataAdapter adapter = null;

        try
        {
            adapter = new SqlDataAdapter
              (
                "Person.SearchByLastName",
                sqlconnection
              );

            adapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            adapter.SelectCommand.Parameters.Add
              (
                "@LastName",
                SqlDbType.VarChar,
                50
              ).Value = LastName;

            adapter.Fill(result);
        }
        catch (Exception ex)
        {
            throw (ex);
        }
        finally
        {
            if (adapter != null)
                adapter.Dispose();
        }

        return result;
    }
}
