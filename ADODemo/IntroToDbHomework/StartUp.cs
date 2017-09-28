namespace IntroToDbHomework
{
    using System;
    using System.Data.SqlClient;
    using System.IO;
    using System.Linq;
    using System.Runtime.InteropServices;

    public class StartUp
    {
       public static void Main()
        {
            SqlConnection dbcon=new SqlConnection("Server =.\\SQLEXPRESS; Initial Catalog = MinionsDB; Integrated Security = true; ");
            dbcon.Open();

            using (dbcon)
            {
                //read input
                var minionInfo = Console.ReadLine().Split().ToArray();
                var minionName = minionInfo[1];
                var minionAge = minionInfo[2];
                var townName = minionInfo[3];

                var villainInfo = Console.ReadLine().Split().ToArray();
                var villainName = villainInfo[1];




                //check town
            }
        }

        private static void FindMinionNames(SqlConnection dbcon)
        {
            Console.WriteLine("Please insert villain Id");
            int villainId = int.Parse(Console.ReadLine());

            string findVillainNameQuery = File.ReadAllText("../../FindVillainName.sql");
            SqlCommand cmdVillainName = new SqlCommand(findVillainNameQuery, dbcon);
            var villainParam = new SqlParameter("@villainId", villainId);

            cmdVillainName.Parameters.Add(villainParam);
            var reader = cmdVillainName.ExecuteReader();
            if (reader.Read())
            {
                Console.WriteLine($"Villain: {reader["name"]}");

                reader.Close();
                string findMinionNamesQuery = File.ReadAllText("../../FindMinionNamesForVillainId.sql");
                var minionParam = new SqlParameter("@villainId", villainId);
                SqlCommand cmdMinionsNames = new SqlCommand(findMinionNamesQuery, dbcon);
                cmdMinionsNames.Parameters.Add(minionParam);
                var reader2 = cmdMinionsNames.ExecuteReader();
                if (!reader2.Read())
                {
                    Console.WriteLine("(no minions)");
                }
                else
                {
                    var index = 1;
                    while (reader2.Read())
                    {
                        Console.WriteLine($"{index}. {reader2["Name"]} {reader2["Age"]}");
                        index++;
                    }
                }
            }
            else
            {
                Console.WriteLine($"No villain with ID {villainId} exists in the database.");
            }
        }

        private static void GetVillainsNames(SqlConnection dbcon)
        {
            string query = File.ReadAllText("../../FindAllVillainsNames.sql");
            SqlCommand cmd = new SqlCommand(query, dbcon);

            SqlDataReader reader = cmd.ExecuteReader();

            while (reader.Read())
            {
                var villainName = reader["Name"];
                var minionsCount = reader["MinionsCount"];
                Console.WriteLine($"{villainName} {minionsCount}");
            }
        }
    }
}
