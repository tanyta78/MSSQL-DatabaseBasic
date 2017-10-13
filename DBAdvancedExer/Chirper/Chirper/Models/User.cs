namespace Chirper.Models
{
    using System.Collections.Generic;

    public class User
    {
        public User()
        {
            this.Chirps = new HashSet<Chirp>();
        }

        public int Id { get; set; }

        public string Alias { get; set; }

        public virtual ICollection<Chirp> Chirps { get; set; }

        public int CurrentSessionId { get; set; }
    }
}
