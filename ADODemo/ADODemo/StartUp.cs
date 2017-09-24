namespace ADODemo
{
    using System;
    using System.Data.SqlClient;
   
    class StartUp
    {
        static void Main()
        {
            SqlConnection dbCon = new SqlConnection(@"
                Server=.;
                Database=SoftUni;
                Integrated Security=true");

            dbCon.Open();
            
            Console.WriteLine("Enter town name:");
            string townName = Console.ReadLine();

            using (dbCon)
            {
                //ExecuteScalar()
                string query = "SELECT COUNT(*) AS Count FROM Employees";
                SqlCommand cmd = new SqlCommand(query,dbCon);
                Console.WriteLine("Number of employees: {0}",cmd.ExecuteScalar());

                //ExecuteReader()
                string query2 = "SELECT * FROM Employees";
                SqlCommand cmd2=new SqlCommand(query2,dbCon);
                var reader = cmd.ExecuteReader();

                using (reader)
                {
                  //  reader.Read();//чете по редове това е първия ред
                   // Console.WriteLine(reader[0]);//а така извикваме първата колонка
                   // reader.FieldCount => column count
                   // reader.GetName(0);= col name
                    while (reader.Read())
                    {
                        for (int i = 0; i < reader.FieldCount; i++)
                        {
                            
                            Console.Write(reader[i]);
                        }
                        Console.WriteLine();
                    }
                }

                //ExecuteNonQuery();
                string query3 = $"INSERT INTO Towns VALUES('{townName}')";
                var cmd3=new SqlCommand(query3,dbCon);

              int affected = cmd3.ExecuteNonQuery();//връща броя редове които са засегнати


                //use parameters to protect from sql injection
                string query4 = $"INSERT INTO Towns VALUES(@TownName)";
                var cmd4 = new SqlCommand(query4, dbCon);
                cmd4.Parameters.AddWithValue("@TownName", townName);
            }

        }
    }
}
