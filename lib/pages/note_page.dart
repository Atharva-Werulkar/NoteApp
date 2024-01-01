import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app/components/drawer.dart';
import 'package:note_app/components/note_tile.dart';
import 'package:note_app/models/note.dart';
import 'package:note_app/models/note_database..dart';
import 'package:provider/provider.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  // text controller
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //on app startup, read all notes
    readNote();
  }

  //create a note
  void createNote() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        content: TextField(
          cursorColor: Theme.of(context).colorScheme.inversePrimary,
          decoration: InputDecoration(
            hintText: 'Enter your note',
            hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
          controller: _textController,
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              //add note to database
              if (_textController.text.isNotEmpty) {
                //add note to database
                context.read<NoteDatabase>().addNote(_textController.text);

                //clear text field
                _textController.clear();
              } else {
                const ScaffoldMessenger(
                  child: Text('Please enter some text'),
                );
              }

              //close dialog
              Navigator.pop(context);
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  //read a note
  void readNote() {
    context.read<NoteDatabase>().fetchNotes();
  }

  //update a note
  void updateNote(Note note) {
    //per-fill the current note text
    _textController.text = note.text;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: const Text('Update Note'),
        content: TextField(
          cursorColor: Theme.of(context).colorScheme.inversePrimary,
          decoration: InputDecoration(
            hintText: 'Enter your note',
            hintStyle: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
          controller: _textController,
        ),
        actions: [
          //update button
          MaterialButton(
            onPressed: () {
              //update note in database
              if (_textController.text.isNotEmpty) {
                //update note in database
                context.read<NoteDatabase>().updateNote(
                      note.id,
                      _textController.text,
                    );

                //clear text field
                _textController.clear();
              } else {
                const ScaffoldMessenger(
                  child: Text('Please enter some text'),
                );
              }

              //close dialog
              Navigator.pop(context);
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  //delete a note
  void deleteNote(int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        title: const Text('Delete Note'),
        content: const Text('Are you sure you want to delete this note?'),
        actions: [
          //cancel button
          MaterialButton(
            onPressed: () {
              //close dialog
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          //delete button
          MaterialButton(
            onPressed: () {
              //delete note from database
              context.read<NoteDatabase>().deleteNote(id);

              //close dialog
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //note database
    final noteDatabase = context.watch<NoteDatabase>();

    //current notes
    List<Note> currentNotes = noteDatabase.currentNotes;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      //App Bar
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),

      //Drawer
      drawer: const MyDrawer(),

      //FAB
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        onPressed: () {
          createNote();
        },
        child: Icon(
          Icons.add,
          color: Theme.of(context).colorScheme.background,
        ),
      ),

      //Body
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Heading
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: Text(
              'Notes',
              style: GoogleFonts.dmSerifText(
                  fontSize: 40,
                  color: Theme.of(context).colorScheme.inversePrimary),
            ),
          ),
          //List of Notes
          Expanded(
            child: ListView.builder(
              itemCount: currentNotes.length,
              itemBuilder: (context, index) {
                final note = currentNotes[index];
                //return a list tile
                return NoteTile(
                  text: note.text,
                  onEditPressed: () {
                    updateNote(
                      note,
                    );
                  },
                  onDeletePressed: () {
                    deleteNote(
                      note.id,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
