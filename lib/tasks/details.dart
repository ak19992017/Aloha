import 'package:aloha/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen(
      {super.key, required this.task, required this.description});
  final String task, description;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar.large(
          title: Text(widget.task,
              // 'Nine Work Habits That Can Improve Your Productivity And Focus',
              style: Theme.of(context).textTheme.headlineLarge),
          centerTitle: true,
          elevation: 10,
          expandedHeight: 250,
          pinned: false,
          actions: [
            IconButton.filledTonal(
              icon: Icon(LucideIcons.star),
              onPressed: () {},
            ),
            IconButton.filledTonal(
              icon: Icon(LucideIcons.ellipsis_vertical),
              onPressed: () {
                showModalBottomSheet(
                  clipBehavior: Clip.hardEdge,
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => Container(
                    height: MediaQuery.of(context).size.height / 3,
                    margin: EdgeInsets.all(4),
                    child: ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(title: Text('Settings ${index + 1}'));
                      },
                      itemCount: 5,
                    ),
                  ),
                  // Message(
                  //   task: task['task'] ?? '',
                  //   description: task['description'] ?? '',
                  // ),
                  // shape: const RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.only(
                  //     topLeft: Radius.circular(50),
                  //     topRight: Radius.circular(50),
                  //   ),
                  // ),
                );
              },
            ),
          ],
          leading: IconButton.filledTonal(
            icon: Icon(LucideIcons.chevron_left),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Text(
              widget.description,
              // 'Points \n1. Develop A Morning And Evening Routine\nI think developing a habit for starting and ending your day is helpful in creating a routine and setting you up to be productive. Starting your day entails taking time to review your email update your to-do list and prioritize the work for the day. Ending your day is a process that includes doing a final review of your email reviewing your day and your to-do list progress and planning for the next day. These processes create a system of “plan do review repeat” and allow you to be more organized more deliberate with your time and more productive. \n2. Prioritize Activity As Well As Rest\nTry to do some physical activity at least one hour per day to keep your energy level optimal. Moreover I believe it is essential that we do not forget to rest. Teach your team the importance of taking at least one day a week to rest. This will help them in the long run to avoid burnout and keep a good social life. When you\'re a leader it is always crucial to take care of your people and we have to remember that without them we wouldn\'t be able to do many things we take for granted from time to time. No meaningful and helpful project was ever built alone. We must remember that behind every successful entrepreneur lies a team that fought beside them.\n3. Focus On Energy Management\nI recommend my team start the day at their highest possible self with a calm mind I always encourage them to find a routine and say affirmations then focus on energy management when scheduling the days tasks. I find that the best time of day for me to do focused work is in the morning before lunch. This is when I\'m most energetic and my mind is clear from distractions. I block out a couple of hours each morning for meaningful work and then take a break for lunch. In the afternoon I\'ll usually do more administrative tasks or tackle projects that require less concentration. Be proactive. Get your most important things done early and quickly so that you\'re not allowing tasks to take over your entire schedule. Once you find your most effective routine stick to it and then become a master at it.\n4. Change Up Your Work Environment\nI give my team members the flexibility to switch up their work environment. In fact I encourage them to do so especially if that helps them increase their productivity. Even if it means they have to leave the office to work at their favorite coffee shop whatever helps them be more productive is fine with me. Some of my team members like to work outside if the weather permits. Something as simple as having a standing desk can work too.\n5. Add Tasks To A Calendar\nDon\'t just have a to-do list; schedule tasks in your calendar so you know when you\'re going to tackle each project. It\'s easier to focus when you have a schedule rather than looking at your list and wondering what to do first. Of course you also need to be flexible as sometimes you\'ll have to make adjustments if there\'s an emergency or if an urgent new task suddenly appears. In such cases change your schedule accordingly. You can use an app such as HourStack or Sunsama for time blocking or you can write it down manually—whatever works best for you.\n6. Work On Effective Time Management\nOne habit I recommend my team build to be more productive and focused is effective time management. We’re a fully remote company and everyone is responsible for managing their own time. Some of us are early birds others complete night owls but with that flexibility comes the need for effective time management skills to ensure the work gets done on time and to a high standard. One way I help my team achieve this is by keeping our team and one-on-one check-ins to set days during the week so they know what to plan around and everyone has the space to dive into deep work.\n7. Schedule Time For Deep Focus\nI expect my team and myself to be high performers so I adamantly recommend scheduling "deep focus" at whatever time best suits your personal workflow. This means you do not schedule meetings during this time and are not doing menial tasks like answering emails or even looking at your phone. The purpose of this time is to complete the biggest and most detailed tasks on your list. If you can be disciplined enough to shut out the world for at least two hours per workday you will move the needle forward in an exponential way. A big part of implementing this type of work is setting up a culture that understands and highly regards this time. If it is adopted and valued by C-suite to entry-level roles you will see your company\'s productivity skyrocket overall and employees thrive in their positions.\n8. Make A Daily Goal List\nIf someone is having trouble focusing I recommend starting with something simple like setting a daily goal list to increase their clarity and sense of purpose. To focus on one task at a time I suggest using the Pomodoro technique where you work for 25 minutes and then take a five-minute break. By creating focus and making small changes you can work on building good habits that last rather than making radical changes that are difficult to maintain. \n9. Communicate Your Needs\nBeing in the habit of communicating your needs with your team helps create an environment where you can succeed and be productive. Over time our preferences and needs may change. A project that once inspired us may no longer do so. It may in turn be difficult to be productive and focused on something that we no longer enjoy or are inspired by. By recognizing this change in needs and communicating it to your team a collaborative solution can be found that can help reinvigorate you bringing back your passion and with it your productivity. It may be focusing on a different part of the project that is more inspiring and challenging or even moving to a different team altogether that returns your sense of joy and excitement. Being in tune with your needs and communicating them is key.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
        // SliverList.builder(
        //     itemCount: 20,
        //     itemBuilder: (_, index) {
        //       return Padding(
        //         padding:
        //             const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        //         child: ListTile(
        //           title: Text(
        //             'Hello',
        //             overflow: TextOverflow.ellipsis,
        //             maxLines: 1,
        //             style: Theme.of(context)
        //                 .textTheme
        //                 .headlineMedium
        //                 ?.copyWith(color: Colors.white),
        //           ),
        //           shape: RoundedRectangleBorder(
        //               borderRadius: BorderRadius.circular(20)),
        //           tileColor: giveCategoryGetColor('code'),
        //           contentPadding:
        //               const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        //         ),
        //       );
        //     })
      ],
    ));
  }
}
