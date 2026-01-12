import 'package:flutter/material.dart';

class Module13Class4 extends StatefulWidget {
  const Module13Class4({super.key});

  @override
  State<Module13Class4> createState() => _Module13Class4State();
}

class _Module13Class4State extends State<Module13Class4> {
  // ভেরিয়েবল ডিক্লারেশন (অ্যানিমেশন বা অবস্থার পরিবর্তনের জন্য)

  // সাধারণ কন্টেইনারের হাইট পরিবর্তনের জন্য
  bool NonAniselected = false; 

  // অ্যানিমেটেড কন্টেইনারের হাইট ও রং পরিবর্তনের জন্য
  bool selected = false; 

  // কার্ড বা মেসেজটি দেখানো হবে কি না তা ঠিক করতে
  bool showMessage = false; 

  // প্রোফাইল ছবি মুভ করার জন্য (Align অ্যানিমেশন)
  bool isLogin = false; 

  // নিচের প্যানেলটি উপরে উঠবে কি না তা ঠিক করতে
  bool showPanel = false; 

  // কার্ট আইটেমের সংখ্যা গুনার জন্য
  int cartCount = 0; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animation'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            
            // ---------------------------------------------------
            // ১. AnimatedContainer উদাহরণ
            // ---------------------------------------------------
            GestureDetector(
              onTap: () {
                setState(() {
                  // ক্লিক করলে true/false টগল হবে এবং UI আপডেট হবে
                  selected = !selected;
                });
              },
              child: AnimatedContainer(
                // duration: অ্যানিমেশনটি সম্পন্ন হতে কত সময় নিবে ( ৩০০ মিলি সেকেন্ড)
                duration: Duration(milliseconds: 300),
                
                // যদি selected true হয় হাইট ১৪০, না হলে ১১০ হবে (স্মুথলি বড়/ছোট হবে)
                height: selected ? 140 : 110,
                
                decoration: BoxDecoration(
                  // রঙ পরিবর্তন হওয়ার সময়ও অ্যানিমেশন হবে
                  color: selected ? Colors.green : Colors.grey,
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Text('Product card (Animated)'),
              ),
            ),
            
            SizedBox(
              height: 20,
            ),

            // ---------------------------------------------------
            // ২. সাধারণ Container (পার্থক্য বোঝার জন্য)
            // ---------------------------------------------------
            GestureDetector(
              onTap: () {
                setState(() {
                  NonAniselected = !NonAniselected;
                });
              },
              child: Container(
                // এখানে কোনো অ্যানিমেশন হবে না, হুট করে সাইজ বদলে যাবে
                height: NonAniselected ? 140 : 110,
                decoration: BoxDecoration(
                  color: NonAniselected ? Colors.green : Colors.grey,
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: Text('Product card (Normal)'),
              ),
            ),
            
            SizedBox(
              height: 50,
            ),
            Divider(),
            
            // ---------------------------------------------------
            // ৩. AnimatedOpacity উদাহরণ (Add to cart বাটন)
            // ---------------------------------------------------
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    // বাটন চাপলে মেসেজটি দৃশ্যমান হবে
                    showMessage = !showMessage;
                  });
            
                  // ৩ সেকেন্ড পর অটোমেটিক মেসেজটি আবার গায়েব হয়ে যাবে
                  Future.delayed(Duration(seconds: 3), () {
                    setState(() {
                      showMessage = false;
                    });
                  });
                },
                child: Text('Add to cart')),
            
            // এই উইজেটটি ধীরে ধীরে দৃশ্যমান বা অদৃশ্য হয় (Fade Effect)
            AnimatedOpacity(
              // showMessage true হলে পুরোপুরি দেখা যাবে (1), false হলে অদৃশ্য (0)
              opacity: showMessage ? 1 : 0, 
              duration: Duration(milliseconds: 700), // ০.৭ সেকেন্ড সময় নিবে
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 6,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 13),
                    child: Text(
                      'Added to cart',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
            
            // ---------------------------------------------------
            // ৪. AnimatedSwitcher উদাহরণ (সংখ্যা পরিবর্তন অ্যানিমেশন)
            // ---------------------------------------------------
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Cart: '),
                // যখনই child উইজেট পরিবর্তন হয়, এটি একটি ট্রানজিশন ইফেক্ট দেয়
                AnimatedSwitcher(
                  duration: Duration(
                    milliseconds: 1000,
                  ),
                  // key ব্যবহার করা জরুরি যাতে Flutter বোঝে যে উইজেটটি বদলেছে
                  child: Text(
                    '$cartCount',
                    key: ValueKey(cartCount), 
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        cartCount++; // সংখ্যা বাড়াবে
                      });
                    },
                    icon: Icon(Icons.add))
              ],
            ),
            
            // ---------------------------------------------------
            // ৫. AnimatedAlign উদাহরণ (লগিন প্রোফাইল মুভমেন্ট)
            // ---------------------------------------------------
            SizedBox(
              height: 300,
              width: double.infinity,
              child: AnimatedAlign(
                // isLogin true হলে উপরে চলে যাবে, false হলে মাঝখানে থাকবে
                alignment: isLogin ? Alignment.topCenter : Alignment.center,
                duration: Duration(milliseconds: 1000),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQrN3fMD9X1_p5b6lRSCGcpDtH9BcgEOsEZLg&s'),
                  radius: 50,
                ),
              ),
            ),
            
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    isLogin = !isLogin;
                  });
                },
                child: Text('Login')),

            SizedBox(height: 30,),
            
            // ---------------------------------------------------
            // ৬. AnimatedPositioned উদাহরণ ( Stack এর ভেতরে)
            // ---------------------------------------------------
            SizedBox(
              height: 200,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                      child: ElevatedButton(onPressed: (){
                        setState(() {
                          showPanel = !showPanel; // প্যানেল টগল করবে
                        });

                        // ৩ সেকেন্ড পর প্যানেলটি আবার নিচে চলে যাবে
                        Future.delayed(Duration(seconds: 3), () {
                          setState(() {
                            showPanel = false;
                          });
                        });
                      }, child: Text('Toggle bottom'))),
                  
                  // এটি পজিশন পরিবর্তন করার সময় অ্যানিমেশন তৈরি করে
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 800),
                    // showPanel true হলে নিচে লেগে থাকবে (0), false হলে স্ক্রিনের বাইরে চলে যাবে (-120)
                    bottom: showPanel ? 0 : -120, 
                    left: 0,
                     right: 0,
                    child: Container(
                      height: 120,
                      color: Colors.blue,
                      alignment: Alignment.center,
                      child: Text('Bottom panel', style: TextStyle(color: Colors.white)),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
