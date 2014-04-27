namespace Basics
{
    using System;
    class Program
    {
        static void Main(string[] args)
        {
            DataTime();
            Checking();
            ImplicitTyping();
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

        private static void ImplicitTyping()
        {
            var i = 0;
            var b = true;
            var s = "Hello";
            var f = 3.33;

            Console.WriteLine("i is {0}", i.GetType().Name);
            Console.WriteLine("b is {0}", b.GetType().Name);
            Console.WriteLine("s is {0}", s.GetType().Name);
            Console.WriteLine("f is {0}", f.GetType().Name);
        }
    }
}
