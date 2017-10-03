namespace IntroToEF
{
    using System;
    using System.Linq;
    using System.Runtime.InteropServices;
    using System.Text;

    public class StartUp
    {
      public static void Main()
        {

            SoftuniContext context = new SoftuniContext();

            // EmployeesFullInformation(context);

            //EmplFNAmeSalaryOver50000(context);

            //EmplFromResearchAndDev(context);

            //AddAddressToEmployee(context);

            // EmplProjFrom20012003(context);

            //AddressesByTownName(context);

            //Employee147(context);

            //DepWithMoreEmpl(context);

        }

        private static void DepWithMoreEmpl(SoftuniContext context)
        {
            var departments = context.Departments
                .Where(d => d.DepartmentEmployees.Count > 5)
                .OrderBy(d => d.DepartmentEmployees.Count)
                .ToList();
            foreach (var dep in departments)
            {
                Console.WriteLine($"{dep.Name} {dep.Manager.FirstName}");

                foreach (var emp in dep.DepartmentEmployees)
                {
                    Console.WriteLine($"{emp.FirstName} {emp.LastName} {emp.JobTitle}");
                }
            }
        }

        private static void Employee147(SoftuniContext context)
        {
            var employee = context.Employees.FirstOrDefault(e => e.EmployeeID == 147);
            if (employee == null)
            {
                throw new ArgumentNullException("There is no employee with ID 147");
            }
            Console.WriteLine($"{employee.FirstName} {employee.LastName} {employee.JobTitle}");
            foreach (var name in employee.Projects.OrderBy(p => p.Name).Select(p => p.Name).ToList())
            {

                Console.WriteLine(name);
            }
        }

        private static void AddressesByTownName(SoftuniContext context)
        {
            var adresses = context.Addresses
                            .OrderByDescending(a => a.Employees.Count)
                            .ThenBy(a => a.Town.Name)
                            .Take(10);

            foreach (var a in adresses)
            {
                Console.WriteLine($"{a.AddressText}, {a.Town.Name} - {a.Employees.Count} employees");
            }
        }

        private static void EmplProjFrom20012003(SoftuniContext context)
        {
            var employees = context.Employees.ToList();
            StringBuilder sb = new StringBuilder();
            foreach (var employee in employees)
            {
                var emplProjects = employee.Projects
                    .Where(p => p.StartDate.Year >= 2001 && p.StartDate.Year <= 2003).ToList();

                if (emplProjects.Count > 0)
                {
                    if (employee.Manager == null)
                    {
                        sb.AppendLine($"{employee.FirstName} {employee.LastName} ");
                    }
                    else
                    {
                        sb.AppendLine($"{employee.FirstName} {employee.LastName} {employee.Manager.FirstName}");
                    }

                    foreach (var project in emplProjects)
                    {
                        sb.AppendLine($"--{project.Name} {project.StartDate:M/d/yyyy h:mm:ss tt} {project.EndDate:M/d/yyyy h:mm:ss tt}");
                    }
                }
            }

            Console.Write(sb.ToString());
        }


        private static void AddAddressToEmployee(SoftuniContext context)
        {
            Address address = new Address();
            address.AddressText = "Vitoshka 15";
            address.TownID = 4;

            context.Addresses.Add(address);

            var employees = context.Employees
                .Where(e => e.LastName == "Nakov");

            foreach (var employee in employees)
            {
                employee.Addresses = address;
            }
            context.SaveChanges();

            var emplAdresses = context.Employees
                 .OrderByDescending(e => e.AddressID)
                 .Take(10)
                 .Select(e => e.Addresses.AddressText)
                 .ToList();

            foreach (var adress in emplAdresses)
            {
                Console.WriteLine(adress);
            }
        }

        private static void EmplFromResearchAndDev(SoftuniContext context)
        {
            var employeesReserchDevelop = context.Employees
                            .Where(e => e.Department.Name == "Research and Development")
                            .OrderBy(e => e.Salary)
                            .ThenByDescending(e => e.FirstName);

            foreach (var emp in employeesReserchDevelop)
            {
                Console.WriteLine($"{emp.FirstName} {emp.LastName} from Research and Development - ${emp.Salary:f2}");
            }
        }

        private static void EmplFNAmeSalaryOver50000(SoftuniContext context)
        {
            var employeesName = context.Employees
                .Where(e => e.Salary > 50000)
                .Select(e => e.FirstName);

            foreach (var empName in employeesName)
            {
                Console.WriteLine(empName);
            }
        }

        private static void EmployeesFullInformation(SoftuniContext context)
        {
            var employees = context.Employees.ToList().OrderBy(e => e.EmployeeID);


            foreach (var e in employees)
            {
                Console.WriteLine($"{e.FirstName} {e.LastName} {e.MiddleName} {e.JobTitle} {e.Salary:f4}");
            }
        }
    }
}
