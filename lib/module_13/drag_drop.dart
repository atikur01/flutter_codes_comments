import 'package:flutter/material.dart'; // ফ্ল্যাটার এর ম্যাটেরিয়াল ডিজাইন প্যাকেজ ইম্পোর্ট করা হচ্ছে।

class DragDrop extends StatelessWidget { // একটি স্টেইটলেস উইজেট ক্লাস তৈরি করা হচ্ছে।
  const DragDrop({super.key}); // ক্লাসের কনস্ট্রাক্টর।

  @override
  Widget build(BuildContext context) { // UI তৈরি করার প্রধান মেথড।
    
    // ফলের নামের একটি লিস্ট তৈরি করা হলো যা আমরা ড্র্যাগ করব।
    List<String> fruits = ["Apple", "Banana", "Orange", "Mango"];
    
    // বাস্কেটের জন্য একটি খালি লিস্ট, যেখানে ড্রপ করা আইটেম জমা হবে।
    List<String> basket = []; 

    return Scaffold( // অ্যাপের মূল কাঠামো।
        appBar: AppBar( // উপরের অ্যাপ বার।
          title: Text('DragDrop shopping'), // অ্যাপ বারের টাইটেল।
        ),
        body: Column(children: [ // উইজেটগুলোকে উপর-নিচে সাজানোর জন্য কলাম নেওয়া হলো।
          
          SizedBox( // উপরের লিস্টের জন্য একটি নির্দিষ্ট হাইট বা উচ্চতা দেওয়া হলো।
            height: 160,
            child: Row( // আইটেমগুলোকে পাশাপাশি রাখার জন্য রো (Row) ব্যবহার করা হলো।
              // fruits লিস্টের প্রতিটি আইটেমকে ম্যাপ করে উইজেটে রূপান্তর করা হচ্ছে।
              children: fruits.map((fruit) { 
                
                return Draggable( // Draggable উইজেট ব্যবহার করা হয় কোনো কিছু টেনে সরানোর জন্য।
                  data: fruit, // ড্র্যাগ করার সময় কোন ডাটা (ফলের নাম) পাস হবে তা এখানে বলা হচ্ছে।
                  
                  feedback: Material( // ব্যবহারকারী যখন আইটেমটি টেনে ধরবে, তখন সেটি দেখতে কেমন হবে।
                    color: Colors.transparent, // পেছনের কালার স্বচ্ছ রাখা হলো।
                    child: Chip( // চিপ উইজেট দিয়ে ফলের নাম সুন্দর করে দেখানো হচ্ছে।
                      label: Text(fruit),
                      backgroundColor: Colors.greenAccent, // টানার সময় কালার হবে গ্রিন এক্সেন্ট।
                    ),
                  ),
                  
                  childWhenDragging: Opacity( // যখন আইটেমটি টানা হচ্ছে, তখন আসল জায়গায় যা রয়ে যাবে।
                    opacity: 0.4, // সেটাকে একটু ঝাপসা (0.4) করে দেওয়া হলো।
                    child: Chip(label: Text(fruit)),
                  ),
                  
                  child: Chip(label: Text(fruit)), // স্বাভাবিক অবস্থায় আইটেমটি যেমন দেখাবে।
                );
              }).toList(), // ম্যাপ করা আইটেমগুলোকে লিস্টে রূপান্তর করা হলো।
            ),
          ),
          
          SizedBox( // মাঝখানে একটু ফাঁকা জায়গা রাখার জন্য।
            height: 50,
          ),
          
          // DragTarget হলো সেই জায়গা যেখানে আমরা আইটেমটি ড্রপ করব বা ফেলব।
          DragTarget<String>( 
            onAccept: (receivedItem) { // যদি আইটেমটি সফলভাবে ড্রপ করা হয়, তখন এই ফাংশন কাজ করবে।
              basket.add(receivedItem); // বাস্কেট লিস্টে নতুন আইটেম যোগ করা হলো।
              // সমস্যা: এখানে setState নেই, তাই স্ক্রিনে আপডেট দেখা যাবে না।
            },
            
            // builder ঠিক করে যে ড্রপ করার বক্সটি দেখতে কেমন হবে।
            // context, cData (candidate data - যা ড্রপ হতে যাচ্ছে), rData (rejected data)
            builder: (context, cData, rData) { 
              return Container( // ড্রপ জোনের ডিজাইন।
                height: 200, // বক্সের উচ্চতা।
                width: double.infinity, // বক্সটি পুরো স্ক্রিনের প্রস্থ জুড়ে থাকবে।
                decoration: BoxDecoration( // বক্স সাজানোর জন্য ডেকোরেশন।
                  color: Colors.orange[100], // ব্যাকগ্রাউন্ড কালার হালকা কমলা।
                  border: Border.all(width: 3, color: Colors.orange), // বর্ডার বা সীমানা।
                  borderRadius: BorderRadius.circular(12), // কোনাগুলো একটু গোল করা হলো।
                ),
                
                // যদি বাস্কেট খালি থাকে তবে টেক্সট দেখাবে, আর না হলে বাস্কেটের আইটেমগুলো দেখাবে।
                child: basket.isEmpty 
                    ? Center(child: Text('Drag items here to add to basket')) // খালি অবস্থায় মেসেজ।
                    : Wrap( // আইটেমগুলো বক্সের মধ্যে সুন্দরভাবে সাজানোর জন্য Wrap ব্যবহার করা হলো।
                        children: basket.map((item) => Chip( // বাস্কেটের আইটেমগুলো দেখানো হচ্ছে।
                              label: Text(item),
                              backgroundColor: Colors.orange[300], // বাস্কেটের ভেতরের আইটেমের কালার।
                            )).toList()
                      ),
              );
            },
          ),
        ]));
  }
}
