using System;
using System.Data.SqlClient;

namespace Apress.Examples
{
    class Listing15_1
    {
        static void Main(string[] args)
        {
            string sqlconnect = "DATA SOURCE=SQL2008;" +
              "INITIAL CATALOG=AdventureWorks;" +
              "INTEGRATED SECURITY=SSPI;";

            string sqlcommand = "SELECT " +
              "   DepartmentId, " +
              "   Name, " +
              "   GroupName " +
              " FROM HumanResources.Department " +
              " ORDER BY DepartmentId";

            SqlConnection connection = null;
            SqlCommand command = null;
            SqlDataReader datareader = null;

            try
            {
                connection = new SqlConnection(sqlconnect);
                connection.Open();
                command = new SqlCommand(sqlcommand, connection);
                datareader = command.ExecuteReader();

                while (datareader.Read())
                {
                    Console.WriteLine
                      (
                        "{0}\t{1}\t{2}",
                        datareader["DepartmentId"].ToString(),
                        datareader["Name"].ToString(),
                        datareader["GroupName"].ToString()
                      );
                }
            }
            catch (SqlException ex)
            {
                Console.WriteLine(ex.Message);
            }
            finally
            {
                if (datareader != null)
                    datareader.Dispose();
                if (command != null)
                    command.Dispose();
                if (connection != null)
                    connection.Dispose();
            }
            Console.Write("Press a Key to Continue...");
            Console.ReadKey();
        }
    }
}
