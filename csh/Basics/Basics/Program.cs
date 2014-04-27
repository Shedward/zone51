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

            byte a = 100;
            byte b = 212;
            Console.WriteLine("100 + 212 = {0}", a + b);
            Console.WriteLine("100 + 212 = {0}", (byte)(a + b));
            checked
            {
                // Console.WriteLine("100 + 212 = {0}", (byte)(a + b));
            }
            // Console.WriteLine("100 + 212 = {0}", checked((byte)(a + b)));
        }
    }
}
