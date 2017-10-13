namespace Chirper.ModelConfigurations
{
    using System.Data.Entity.ModelConfiguration;
    using Models;

    public class UserConfiguration : EntityTypeConfiguration<User>
    {
        public UserConfiguration()
        {
            this.Property(u => u.Alias)
                .IsRequired()
                .HasMaxLength(50)
                .IsUnicode(false);

           this.Ignore(u => u.CurrentSessionId);
        }
    }
}
