namespace Homework
{
    using System;
    using System.Data.SqlClient;
    using System.IO;

    public class StartUp
    {
        static void Main()
        {
            // in this query we can input db creation sql query
            // string query = File.ReadAllText("../../ItitialSetup.sql");

            SqlConnection dbcon =
                new SqlConnection("Server=.\\SQLEXPRESS;Initial Catalog=MinionsDB;Integrated Security = true;");
            dbcon.Open();

            using (dbcon)
            {
                Console.WriteLine("Please insert vilian id");
                int vilianId = int.Parse(Console.ReadLine());

                string query = @"
SELECT  v.Name,m.Name,m.Age
FROM Vilians AS v
JOIN ViliansMinions AS vm ON v.Id=vm.VilianId
JOIN Minions AS m ON m.Id=vm.MinionId
where v.id=@VilianId";

                SqlCommand cmd = new SqlCommand(query,dbcon);
                cmd.Parameters.AddWithValue("@VilianId", vilianId);

                var reader = cmd.ExecuteReader();
                using (reader)
                {
                    if (!reader.HasRows)
                    {
                        if (!reader.Read())
                        {
                            Console.WriteLine($"No villain with ID {vilianId} exists in the database.");
                        }
                        else
                        {
                            Console.WriteLine("(no minions)");
                        }
                        
                        return;
                    }
                    reader.Read();
                    Console.WriteLine($"Viliant: {reader[0]}");
                    Console.WriteLine("=====================");
                    for (int i = 0; i < reader.FieldCount; i++)
                    {
                        reader.Read();
                        
                        Console.WriteLine($"{i+1}. {reader[1],-12}| {reader[2],-12} ");
                        Console.WriteLine("=====================");
                    }
                }
            }

        }

        public static void GetAllVilainsNames(SqlConnection dbcon)
        {
            string query = @"
SELECT Name,count(*)as [Number of minions]
FROM Vilians
JOIN ViliansMinions on ViliansMinions.VilianId=Vilians.Id
GROUP BY Vilians.Name
HAVING count(*)>3
ORDER BY count(*) desc";

            SqlCommand cmd = new SqlCommand(query, dbcon);

            SqlDataReader reader = cmd.ExecuteReader();
            using (reader)
            {
                if (!reader.HasRows)
                {
                    Console.WriteLine("There are no vilians with more than 3 minions!");
                    return;
                }
                Console.WriteLine("Vilian name | Number of minions");
                Console.WriteLine("============+==================");
                while (reader.Read())
                {

                    Console.WriteLine($"{reader[0],-12}| {reader[1]} ");
                    Console.WriteLine("------------+-----------------");
                }
            }
        }
    }
}
