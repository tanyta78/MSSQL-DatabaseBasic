namespace Organazer.Data.Migrations
{
    using System.Data.Entity.Migrations;
    using Models.Contacts;

    internal sealed class Configuration : DbMigrationsConfiguration<Organazer.Data.OrganazerContext>
    {
        public Configuration()
        {
            AutomaticMigrationsEnabled = false;
            ContextKey = "Organazer.Data.OrganazerContext";
        }

        protected override void Seed(Organazer.Data.OrganazerContext context)
        {
            var contact1 = new Person
            {
                FirstName = "Ivan",
                LastName = "Ivanov"
            };

            var contact2 = new Person
            {
                FirstName = "Petar",
                LastName = "Petrov",
                Alias = "Pepo"
            };

            context.People.AddOrUpdate(c=>new
            {
                c.FirstName,
                c.LastName
            },contact1,contact2 );

            context.SaveChanges();

        }
    }
}
