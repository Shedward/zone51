namespace Basics
{
    using System;
    class Program
    {
        static void Main(string[] args)
        {
            DataTime();
            Checking();
            Console.ReadKey();
        }

        private static void DataTime()
        {
            DateTime dt = new DateTime(2011, 10, 17);
            Console.WriteLine("The day of {0} is {1}", dt.Date, dt.DayOfWeek);
            var dt2 = dt.AddMonths(2);
            Console.WriteLine("Daylight saving time: {0}", dt2.IsDaylightSavingTime());
        }

        private static void Checking()
        {
            byte a = 100;
            byte b = 212;
            Console.WriteLine("100 + 212 = {0}", a + b);
            Console.WriteLine("100 + 212 = {0}", (byte)(a + b));
            try
            {
                Console.WriteLine("100 + 212 = {0}", checked((byte)(a + b)));
            } 
            catch (OverflowException e)
            {
                Console.WriteLine(e.Message);
            }
        }
    }
}
