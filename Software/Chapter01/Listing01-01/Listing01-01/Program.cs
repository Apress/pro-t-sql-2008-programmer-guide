using System;
using System.IO;

namespace Apress.Samples
{
    class SimpleFileReader
    {
        static void Main(string[] args)
        {
            // This file is located in the Listing01-01 directory, three directories above the bin\Debug
            // directory.  You can change the path here or move the file to another directory
            StreamReader sr = new StreamReader("..\\..\\..\\Person_Person.txt");
            string FirstName = null;
            while ((FirstName = sr.ReadLine()) != null)
            {
                Console.WriteLine(FirstName);
            }
            sr.Dispose();
            // Wait for user to press a key to exit
            Console.WriteLine("Press a key to end");
            Console.ReadKey();
        }
    }
}
