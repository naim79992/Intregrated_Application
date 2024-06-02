import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'BlogWrite.dart';

class Blog extends StatelessWidget {
  const Blog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView(
        children: const [
          BlogPost(
            title: 'First Blog Post',
            excerpt: 'This is the summary of the first blog post...',
            content:
                'This is the full content of the first blog post. Here you can add more details about your topic...',
          ),
          BlogPost(
            title: 'Second Blog Post',
            excerpt: 'This is the summary of the second blog post...',
            content:
                'This is the full content of the second blog post. Here you can add more details about your topic...',
          ),
          // Add more BlogPost widgets as needed
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const BlogWrite(),
            ),
          );
        },
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class BlogPost extends StatelessWidget {
  final String title;
  final String excerpt;
  final String content;

  const BlogPost({
    required this.title,
    required this.excerpt,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: ListTile(
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Text(
          excerpt,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        trailing: const Icon(Icons.arrow_forward),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlogDetail(
                title: title,
                content: content,
              ),
            ),
          );
        },
      ),
    );
  }
}

class BlogDetail extends StatelessWidget {
  final String title;
  final String content;

  const BlogDetail({
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // Share functionality here
              _shareContent(context, title, content);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            content,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ),
    );
  }

  void _shareContent(BuildContext context, String title, String content) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    Share.share(
      '$title\n\n$content',
      subject: title,
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
    );
  }
}
