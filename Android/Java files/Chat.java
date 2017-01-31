package com.example.radibarq.pokemongotradecenter;

import android.app.ActionBar;
import android.app.ProgressDialog;
import android.support.design.widget.FloatingActionButton;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.text.format.DateFormat;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListAdapter;
import android.widget.ListView;
import android.widget.SimpleAdapter;
import android.widget.TextView;

import com.google.firebase.auth.FirebaseAuth;
import com.google.android.gms.common.ConnectionResult;

import com.google.firebase.database.GenericTypeIndicator;
import com.google.firebase.database.ValueEventListener;
import com.firebase.client.DataSnapshot;
import com.firebase.client.FirebaseError;
import com.google.firebase.auth.api.model.StringList;
import com.google.android.gms.common.api.GoogleApiClient;
import com.google.android.gms.location.LocationServices;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;

import org.json.JSONArray;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

public class Chat extends AppCompatActivity {

    ListView listView;
    SimpleAdapter adapter;
    String myJSON;
    ArrayList<HashMap<String, String>> personList;
    public static ArrayList<HashMap<String, String>> messages;
    JSONArray peoples = null;
    DatabaseReference myRef;
    private ProgressDialog pDialog;
    DatabaseReference user1Ref;
    DatabaseReference user2Ref;
    int checker;

    // Related to the active chat
    public static int active;
    public static String key;
    public static String name;
    MessageAdapter messageAdapter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_chat);

        messageAdapter = new MessageAdapter(this);

        /// Related to the diaglog
        pDialog = new ProgressDialog(Chat.this);
        pDialog.setMessage("Loading...");
        pDialog.setIndeterminate(false);
        pDialog.setCancelable(true);
        pDialog.show();
        Button fab =
                (Button) findViewById(R.id.fab);
        listView = (ListView) findViewById(R.id.list_of_messages);
        messages = new ArrayList<HashMap<String, String>>();
        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

                EditText input = (EditText) findViewById(R.id.input);

                if (!input.getText().toString().trim().matches("")) {

                    ChatMessage chatMessage = new ChatMessage(input.getText().toString().trim(), LoginActivity.user.displayName);

                    ChatRoom chatRoom = new ChatRoom(chatMessage, LoginActivity.user.displayName, MainActivity.currentUser.displayName);


                    myRef.push().setValue(chatMessage);

                    messages = new ArrayList<HashMap<String, String>>();

                    input.setText("");

                    checker = 1;
                }
            }
        });

        personList = new ArrayList<HashMap<String, String>>();

        // If it's already active chat
        if (active == 1)
        {
            setTitle(name);
            ActionBar actionBar = getActionBar();
            getSupportActionBar().setDisplayHomeAsUpEnabled(true);
            checker = 0;
            FirebaseDatabase database = FirebaseDatabase.getInstance();
            myRef = database.getInstance().getReference("Users").child(LoginActivity.user.displayName).child("chat").child(name);
            myRef.addValueEventListener(postListener1);
        }

        // If it's not a new chat
        else  {

            setTitle(MainActivity.currentUser.displayName);
            ActionBar actionBar = getActionBar();
            getSupportActionBar().setDisplayHomeAsUpEnabled(true);
            checker = 0;


            FirebaseDatabase database = FirebaseDatabase.getInstance();

            myRef = database.getInstance().getReference("Chat").push();


            String unique = myRef.getKey();

            myRef = database.getInstance().getReference("Chat").child(unique).child(LoginActivity.user.displayName).child(MainActivity.currentUser.displayName);


            user1Ref = database.getInstance().getReference("Users").child(LoginActivity.user.displayName).child("chat");


            user2Ref = database.getInstance().getReference("Users").child(MainActivity.currentUser.displayName).child("chat");

            user1Ref.child(MainActivity.currentUser.displayName).setValue(unique);

            user2Ref.child(LoginActivity.user.displayName).setValue(unique);


            myRef.addValueEventListener(postListener);

        }
    }

    ValueEventListener postListener1 = new ValueEventListener() {
        @Override
        public void onDataChange(com.google.firebase.database.DataSnapshot dataSnapshot) {
            for (com.google.firebase.database.DataSnapshot child : dataSnapshot.getChildren()) {
                HashMap<String, String> message = new HashMap<String, String>();
                for (com.google.firebase.database.DataSnapshot child2 : child.getChildren()) {
                    if (child2.getKey().matches("messageText")) {
                        message.put("messageText", child2.getValue().toString());
                    } else if (child2.getKey().matches("messageFrom")) {
                        message.put("messageFrom", child2.getValue().toString());
                    }
                }

               messageAdapter.addMessage(message);
            }

           pDialog.dismiss();

            //    adapter = new SimpleAdapter(
              //          Chat.this, messages, R.layout.message_left,
                ///        new String[]{"messageText", "messageFrom"},
                   //     new int[]{R.id.message_text, R.id.message_user}
                //);

            listView.setAdapter(messageAdapter);
            listView.setSelection(messageAdapter.getCount() - 1);
        }

        @Override
        public void onCancelled(DatabaseError databaseError) {

        }
    };

    ValueEventListener postListener = new ValueEventListener() {

        @Override
        public void onDataChange(com.google.firebase.database.DataSnapshot dataSnapshot) {


            for (com.google.firebase.database.DataSnapshot child : dataSnapshot.getChildren()) {
                HashMap<String, String> message = new HashMap<String, String>();

                for (com.google.firebase.database.DataSnapshot child2 : child.getChildren()) {

                    if (child2.getKey().matches("messageFrom")) {
                        message.put("messageText", child2.getValue().toString());
                    } else if (child2.getKey().matches("messageFrom")) {
                        message.put("messageFrom", child2.getValue().toString());

                    }
                }

                messageAdapter.addMessage(message);
            }

            pDialog.dismiss();

                //adapter = new SimpleAdapter(
//                        Chat.this, messages, R.layout.message,
   //                     new String[]{"messageText", "messageFrom"},
 // /  //                    new int[]{R.id.message_text, R.id.message_user
       //                 });

                //binder = new SimpleAdapter.ViewBinder() {
                /// @Override
                //public boolean setViewValue(View view, Object object, String value) {
                //if (view.equals((TextView) view.findViewById(R.id.message_text))) {
                //TextView message_user = (TextView) view.findViewById(R.id.textView10);
                //Change color/answer/etc for ricettaTipo
                // message_user.setBackground(getResources().getDrawable(R.drawable.bg_msg_from));
                //checker = 0;
                //}
                //  return false;
                //}

                //};

                listView.setAdapter(messageAdapter);
                listView.setSelection(messageAdapter.getCount() - 1);
        }

        @Override
        public void onCancelled(DatabaseError databaseError) {

        }
    };

    /**
     * react to the user tapping the back/up icon in the action bar
     */
    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case android.R.id.home:
                // this takes the user 'back', as if they pressed the left-facing triangle icon on the main android toolbar.
                // if this doesn't work as desired, another possibility is to call `finish()` here.
                onBackPressed();
                return true;
            default:
                return super.onOptionsItemSelected(item);
        }
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.chat_action_bar, menu);
        return true;
    }
    //and this to



}
