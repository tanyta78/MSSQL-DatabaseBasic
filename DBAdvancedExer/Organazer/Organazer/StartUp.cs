namespace Organazer
{
    using System;
    using Data;

    public class StartUp
    {
        public static void Main()
        {
            var context = new OrganazerContext();
            context.Database.Initialize(true);

            for (int i = 0; i < 10000; i++)
            {
                Console.Write($"{i,4}|{(char)i,-4}");
                if (i%7==0)
                {
                    Console.WriteLine();
                }
            }
        }
    }
}
