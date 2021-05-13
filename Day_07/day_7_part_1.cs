using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;

namespace AOC
{
    public class Day7_Part1
    {
        public class rule
        {
            public int number;
            public string parentBag;
            public string childBag;
        }
        public static void Solution(int entries)
        {
            using(var reader = new StreamReader(@"C:\Users\mcho\OneDrive - GRACE WORLDWIDE (AUSTRALIA) PTY LTD\Documents\AOC\Day_7\Day7Input.txt"))
            {
                
                List<string> listEntries = new List<string>();
                while (!reader.EndOfStream)
                {
                   var line = reader.ReadLine();

                    listEntries.Add(line);
                }
                // Test Data
                var rules = new List<rule>();

                foreach(string entry in listEntries){
                    var values = entry.Split(" contain "); //Split Parent and Child
                    if(values[1].Contains(",")){ //Multi Bag Support
                        string[] list =  values[1].Split(",");
                        foreach(string child in list){
                            var parentBag = (values[0]).Split(new[] {" bag"},StringSplitOptions.None)[0];
                            var number = int.Parse((child.Trim(' ').Split(new[] {' '}, 2))[0]);
                            var childBag = ((child.Trim(' ').Split(new[] {' '}, 2))[1]).Split(new[] {" bag"},StringSplitOptions.None)[0];
                            rules.Add(new rule(){number = number,parentBag = parentBag,childBag = childBag});
                        }
                    }else{ // Single Bag Support
                        if(values[1] != "no other bags."){ //Filter Out No Child Bags
                            var parentBag = (values[0]).Split(new[] {" bag"},StringSplitOptions.None)[0];
                            var number = int.Parse((values[1].Trim(' ').Split(new[] {' '}, 2))[0]);
                            var childBag = ((values[1].Trim(' ').Split(new[] {' '}, 2))[1]).Split(new[] {" bag"},StringSplitOptions.None)[0];
                            rules.Add(new rule(){number = number,parentBag = parentBag,childBag = childBag});
                        }
                    }
                }

                var validBags = new List<string>();
                var currentBags = new List<string>();
                foreach(rule rule in rules){
                   if(rule.childBag.Contains("shiny gold")){
                        //Console.WriteLine(rule.parentBag);
                        validBags.Add(rule.parentBag);
                        currentBags.Add(rule.parentBag);
                   }
                }//currentBags.ToList().ForEach(Console.WriteLine);

                var bagSwap = new List<string>();
                bool match = true;
                int matchCounter = 0;
                while(match == true){
                    //currentBags.ToList().ForEach(Console.WriteLine);    
                    matchCounter = 0;
                    bagSwap.Clear();
                    foreach(string bag in currentBags.ToList()){ 
                        //Console.WriteLine(bag);
                        foreach(rule rule in rules){
                            //Console.Write(bag);Console.WriteLine(rule.parentBag);
                            if(rule.childBag.Contains(bag)){
                                //Console.Write(bag);Console.WriteLine(rule.parentBag);
                                validBags.Add(rule.parentBag);
                                bagSwap.Add(rule.parentBag);
                                matchCounter++;
                            }
                        }Console.WriteLine(matchCounter);
                    }
                    if(matchCounter == 0){match=false;}else{currentBags.Clear();currentBags.AddRange(bagSwap);} //If Zero Matches Returned Reset.
                    Console.WriteLine(matchCounter);            
                }
                int distinctCount = validBags.Distinct().Count();
                Console.WriteLine(distinctCount.ToString());
                //validBags.ForEach(Console.WriteLine);
            }
        }
    }
}
