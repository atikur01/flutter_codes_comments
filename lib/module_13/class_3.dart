import 'package:flutter/material.dart'; // ফ্ল্যাটার এর ম্যাটেরিয়াল ডিজাইন প্যাকেজ ইম্পোর্ট করা হচ্ছে।

class Module13Class3 extends StatelessWidget { // একটি স্টেইটলেস উইজেট ক্লাস তৈরি করা হচ্ছে।
  const Module13Class3({super.key}); // কনস্ট্রাক্টর ডিফাইন করা হচ্ছে।

  @override
  Widget build(BuildContext context) { // UI তৈরি করার প্রধান মেথড।
    
    // কার্ট আইটেমগুলোর জন্য একটি লিস্ট তৈরি করা হচ্ছে যেখানে ম্যাপ আকারে ডাটা (ছবি এবং নাম) আছে।
    List<Map<String, String>> cartItems = [
      {
        'img': 'https://domf5oio6qrcr.cloudfront.net/medialibrary/11525/0a5ae820-7051-4495-bcca-61bf02897472.jpg', // আপেলের ছবির লিংক।
        'name': 'Apple', // ফলের নাম।
      },
      {
        'img': 'https://images.apollo247.in/pd-cms/cms/2025-05/AdobeStock_299290543.webp?tr=q-80,f-webp,w-450,dpr-2,c-at_max', // কলার ছবির লিংক।
        'name': 'Banana', // ফলের নাম।
      },
      {
        'img': 'https://media.gettyimages.com/id/172665473/photo/oranges-wallpaper.jpg?s=612x612&w=gi&k=20&c=jSjvdOhNDuF5u1B4Qw5T1KWZGhFwDfD8G1bhziwHQ_I=', // কমলার ছবির লিংক।
        'name': 'Orange', // ফলের নাম।
      },
      {
        'img': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRH73ee12_Lw-63UujjKcQ25ZTuKtl1_gNUcA&s', // আমের ছবির লিংক।
        'name': 'Mango', // ফলের নাম।
      },
    ];

    return Scaffold( // অ্যাপের বেসিক স্ট্রাকচার বা কাঠামো রিটার্ন করা হচ্ছে।
      appBar: AppBar( // অ্যাপের উপরের বার (App Bar)।
        title: Text('Shoping Cart'), // অ্যাপ বারের টাইটেল বা শিরোনাম।
      ),
      body: ListView.builder( // অনেকগুলো আইটেম লিস্ট আকারে দেখানোর জন্য বিল্ডার ব্যবহার করা হচ্ছে।
          itemCount: cartItems.length, // লিস্টে মোট কতগুলো আইটেম থাকবে (এখানে ৪টি)।
          itemBuilder: (context, index) { // প্রতিটি আইটেম কিভাবে তৈরি হবে তা এখানে বলা হচ্ছে।
            final item = cartItems[index]; // বর্তমান ইনডেক্সের ডাটা 'item' ভেরিয়েবলে রাখা হলো।
            
            return Dismissible( // আইটেমকে সোয়াইপ (ডানে/বামে) করে ডিলিট বা অ্যাকশন করার উইজেট।
              key: Key(item['name']!), // প্রতিটি আইটেমকে আলাদাভাবে চেনার জন্য ইউনিক কি (Key) দেওয়া হচ্ছে।

              confirmDismiss: (direction) async { // সোয়াইপ করার সময় বা পরে কি ঘটবে তা এখানে চেক করা হয়।
                if (direction == DismissDirection.startToEnd) { // যদি বাম থেকে ডানে (Start to End) সোয়াইপ করা হয়।
                  
                  // নিচে একটি স্ন্যাকবার (মেসেজ) দেখানো হবে যে কোয়ান্টিটি বেড়েছে।
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("${item['name']} QTY increased")),
                  );
                  return false; // false রিটার্ন করলে আইটেমটি লিস্ট থেকে মুছে যাবে না (শুধু মেসেজ দেখাবে)।
                  
                } else if (direction == DismissDirection.endToStart) { // যদি ডান থেকে বামে (End to Start) সোয়াইপ করা হয়।
                  
                  // নিচে একটি স্ন্যাকবার (মেসেজ) দেখানো হবে যে আইটেম রিমুভ হয়েছে।
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("${item['name']} removed from cart"))
                  );
                  return true; // true রিটার্ন করলে আইটেমটি UI থেকে সরে যাবে।
                }
                return null;
              },
              
              background: Container( // বাম থেকে ডানে সোয়াইপ করলে পেছনের যে ব্যাকগ্রাউন্ড দেখা যাবে।
                color: Colors.green, // ব্যাকগ্রাউন্ড কালার সবুজ।
                padding: EdgeInsets.symmetric(horizontal: 50), // আইকনের পাশে জায়গা রাখা।
                child: Icon(Icons.add, color: Colors.white), // প্লাস আইকন দেখানো হবে।
              ),

              secondaryBackground: Container( // ডান থেকে বামে সোয়াইপ করলে পেছনের যে ব্যাকগ্রাউন্ড দেখা যাবে।
                color: Colors.red, // ব্যাকগ্রাউন্ড কালার লাল।
                padding: EdgeInsets.symmetric(horizontal: 50), // আইকনের পাশে জায়গা রাখা।
                child: Icon(Icons.delete, color: Colors.white), // ডিলিট আইকন দেখানো হবে।
              ),

              child: Card( // মূল আইটেমটি একটি কার্ডের মধ্যে রাখা হয়েছে।
                child: ListTile( // লিস্টের স্টাইল সুন্দর করার জন্য ListTile ব্যবহার করা হয়েছে।
                  title: Text(item["name"]!), // আইটেমের নাম দেখানো হচ্ছে।
                  leading: Image.network("${item['img']}"), // আইটেমের ছবি বাম পাশে দেখানো হচ্ছে।
                  trailing: Text("QTY: 2", style: TextStyle(fontSize: 16)), // ডান পাশে কোয়ান্টিটি টেক্সট দেখানো হচ্ছে।
                ),
              ),
            );
          }
      ),
    );
  }
}
