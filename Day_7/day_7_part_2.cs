using System;
using System.IO;
using System.Collections.Generic;
using System.Linq;

namespace AOC
{
    public class Day7_Part2
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
                var totalBags = new List<rule>();       //Bags for Calculating Answer
                var currentBags = new List<string>(); currentBags.Add("1_shiny gold");    //Bags for Recursing & //Starting Parameter
                bool match = true;                      //Kill Switch

                while(match == true){   
                    int matchCounter = 0;
                    var bagSwap = new List<string>();       //TempBag
                    foreach(string bag in currentBags.ToList()){
                        foreach(rule rule in rules){
                            if(rule.parentBag.Contains(bag.Split('_')[1])){
                                int bagCount = int.Parse(bag.Split('_')[0]) * rule.number ; //Calulate Accumulative Bag multiplication Value
                                bagSwap.Add(bagCount.ToString() + '_' +  rule.childBag); //Hide Number and ChildBag in String to pass Recursively
                                matchCounter++;
                                totalBags.Add(new rule(){number = bagCount,parentBag = rule.parentBag,childBag = rule.childBag});

                            }
                        }
                    }
                    if(matchCounter == 0){match=false;}else{currentBags.Clear();currentBags.AddRange(bagSwap);} //If Zero Matches Returned Reset.         
                }
                //Finalize Answers
                int sum = 0;
                foreach(rule rule in totalBags){
                    sum = sum + rule.number;
                }
                Console.WriteLine(sum);
            }
        }
    }
}
