namespace Basics
{
    using System;
    class Program
    {
        static void Main(string[] args)
        {
            DateTime dt = new DateTime(2011, 10, 17);
            Console.WriteLine("The day of {0} is {1}", dt.Date, dt.DayOfWeek);
            var dt2 = dt.AddMonths(2);
            Console.WriteLine("Daylight saving time: {0}", dt2.IsDaylightSavingTime());
            Console.ReadKey();
        }
    }
}
