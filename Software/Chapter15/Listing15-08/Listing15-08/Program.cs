﻿using System;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.IO;

namespace Apress.Example
{
    class Listing15_8
    {
        static string sqlconnection = "DATA SOURCE=SQL2008; " +
          "INITIAL CATALOG=AdventureWorks; " +
          "INTEGRATED SECURITY=SSPI;";

        static string sourcefile = "c:\\ZIPCodes.txt";

        static DataTable loadtable = null;

        static void Main(string[] args)
        {
            Stopwatch clock = new Stopwatch();
            clock.Start();
            int rowcount = DoImport();
            clock.Stop();
            Console.WriteLine("{0} Rows Imported in {1} Seconds.",
              rowcount, (clock.ElapsedMilliseconds / 1000.0));
            Console.WriteLine("Press a Key...");
            Console.ReadKey();
        }

        static int DoImport()
        {
            using (SqlBulkCopy bulkcopier = new SqlBulkCopy(sqlconnection))
            {
                bulkcopier.DestinationTableName = "dbo.ZIPCodes";
                try
                {
                    LoadSourceFile();
                    bulkcopier.WriteToServer(loadtable);
                }
                catch (SqlException ex)
                {
                    Console.WriteLine(ex.Message);
                }
            }
            return loadtable.Rows.Count;
        }

        static void LoadSourceFile()
        {
            loadtable = new DataTable();
            DataColumn loadcolumn = new DataColumn();
            DataRow loadrow = null;

            loadcolumn.DataType = typeof(System.String);
            loadcolumn.ColumnName = "ZIP";
            loadcolumn.Unique = true;
            loadtable.Columns.Add(loadcolumn);

            loadcolumn = new DataColumn();
            loadcolumn.DataType = typeof(System.Double);
            loadcolumn.ColumnName = "Latitude";
            loadcolumn.Unique = false;
            loadtable.Columns.Add(loadcolumn);

            loadcolumn = new DataColumn();
            loadcolumn.DataType = typeof(System.Double);
            loadcolumn.ColumnName = "Longitude";
            loadcolumn.Unique = false;
            loadtable.Columns.Add(loadcolumn);

            loadcolumn = new DataColumn();
            loadcolumn.DataType = typeof(System.String);
            loadcolumn.ColumnName = "City";
            loadcolumn.Unique = false;
            loadtable.Columns.Add(loadcolumn);

            loadcolumn = new DataColumn();
            loadcolumn.DataType = typeof(System.String);
            loadcolumn.ColumnName = "State";
            loadcolumn.Unique = false;
            loadtable.Columns.Add(loadcolumn);

            using (StreamReader stream = new StreamReader(sourcefile))
            {
                string record = stream.ReadLine();
                while (record != null)
                {
                    string[] cols = record.Split('\t');
                    loadrow = loadtable.NewRow();
                    loadrow["ZIP"] = cols[0];
                    loadrow["Latitude"] = cols[1];
                    loadrow["Longitude"] = cols[2];
                    loadrow["City"] = cols[3];
                    loadrow["State"] = cols[4];
                    loadtable.Rows.Add(loadrow);
                    record = stream.ReadLine();
                }
            }
        }
    }
}
