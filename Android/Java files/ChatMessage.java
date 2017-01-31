package com.example.radibarq.pokemongotradecenter;

import java.util.Date;

/**
 * Created by radibarq on 10/30/16.
 */

public class ChatMessage {

    public String messageText;
    public String messageFrom;
    public long messageTime;

    public ChatMessage(String messageText, String messageFrom)
    {
        this.messageText = messageText;
        this.messageFrom = messageFrom;
        messageTime = new Date().getTime();
    }
}
