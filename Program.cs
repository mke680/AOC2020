using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AOC
{
    class Program
    {

        private static void Method2(int x)
        {
            Console.WriteLine("fuck");
        }

        private static void Method3(int x)
        {
        }

        
        static void Main(string[] args){
            if (args.Count() != 2)
            {
                throw new ArgumentException(message: "Please Supply Solution Day and Part.", paramName: nameof(args));
            }

            selectSolution(args[0 ],args[1]);
            
        }
        
        static void selectSolution(string day, string part)
        {

            Dictionary<string, Action<int>> methods = new Dictionary<string, Action<int>>();
            methods.Add("1_1", Day1_Part1.Solution);
            methods.Add("1_2",  Day1_Part2.Solution);
            methods.Add("2_1", Day2_Part1.Solution);
            methods.Add("2_2",  Day2_Part2.Solution);
            methods.Add("7_1",  Day7_Part1.Solution);
            methods.Add("7_2",  Day7_Part2.Solution);
            methods.Add("3", Method3);
            //int day = int.Parse(Console.ReadLine());
            //Console.WriteLine(args[0].ToString());

            string dayPart = day + "_" + part;
            (methods[dayPart])(1);
        }
    }
}
