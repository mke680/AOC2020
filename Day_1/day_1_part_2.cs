using System;
using System.IO;
using System.Collections.Generic;

namespace AOC
{
    public class Day1_Part2
    {
        public static void Solution(int args)
        {
            using(var reader = new StreamReader(@"C:\Users\mcho\OneDrive - GRACE WORLDWIDE (AUSTRALIA) PTY LTD\Documents\AOC\Day_1\Day1Nathan.txt"))
            {
                
                List<int> listEntries = new List<int>();
                while (!reader.EndOfStream)
                {
                    var line = reader.ReadLine();
                    var values = line.Split(','); //Delimiter Support

                    listEntries.Add(int.Parse(values[0])); //Console.WriteLine(values[0]);
                }
                // Test Data
                //listEntries.ForEach(i => Console.Write("{0},", i));
                foreach(int entry1 in listEntries){
                    foreach(int entry2 in listEntries){
                        if(entry1 + entry2 < 2020){
                            foreach(int entry3 in listEntries){
                                if(entry1 + entry2 + entry3 == 2020){
                                    Console.WriteLine(entry1 * entry2 * entry3);return;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
