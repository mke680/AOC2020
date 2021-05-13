using System;
using System.IO;
using System.Collections.Generic;

namespace AOC
{
    public class Day2_Part2
    {
        public static void Solution(int args)
        {
            using(var reader = new StreamReader(@"C:\Users\mcho\OneDrive - GRACE WORLDWIDE (AUSTRALIA) PTY LTD\Documents\AOC\Day_2\Day2Input.txt"))
            {
                
                List<string> listEntries = new List<string>();
                while (!reader.EndOfStream)
                {
                    var line = reader.ReadLine();

                    listEntries.Add(line);
                    
                }
                int valid = 0;
                foreach(string entry in listEntries){
                    var values = entry.Split(": "); //Delimiter Support
                    var policy = values[0].Split(" ");

                    var password = values[1];
                    var requirement = policy[1];
                    var rules = policy[0].Split('-');
                    int min = int.Parse(rules[0]) -1;
                    int max = int.Parse(rules[1]) -1;
                
                    //Console.WriteLine(password);
                    if((password[min].ToString() == requirement || password[max].ToString() == requirement) && password[min] != password[max]){valid++;}

                }
                Console.WriteLine(valid.ToString());

            }
        }
    }
}
