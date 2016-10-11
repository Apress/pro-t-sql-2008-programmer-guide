using System;
using System.Data;
using System.Data.SqlTypes;

namespace Apress.Examples
{
    class EndpointClient
    {
        static void Main(string[] args)
        {
            Console.Write("Enter a last name prefix: ");
            string nameprefix = Console.ReadLine();

            AdvPersonSearchService.AdvPersonSearchSoapClient client =
              new AdvPersonSearchService.AdvPersonSearchSoapClient();

            client.ClientCredentials.Windows.ClientCredential =
              System.Net.CredentialCache.DefaultNetworkCredentials;

            client.Open();
            DataSet result = client.SearchByLastName(new SqlString(nameprefix));

            foreach (DataRow row in result.Tables[0].Rows)
            {
                Console.WriteLine
                (
                  "{0}\t{1}\t{2}",
                  row["LastName"].ToString(),
                  row["FirstName"].ToString(),
                  row["MiddleName"].ToString()
                );
            }

            client.Close();

            Console.WriteLine("Press a key to continue...");
            Console.ReadKey();
        }
    }
}
