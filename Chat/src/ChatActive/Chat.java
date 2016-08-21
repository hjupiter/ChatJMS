/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ChatActive;

import java.awt.BorderLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.jms.DeliveryMode;
import javax.jms.JMSException;
import javax.jms.MapMessage;
import javax.jms.MessageProducer;
import javax.jms.Session;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.JTextField;
import org.apache.activemq.ActiveMQConnection;

/**
 *
 * @author Angel
 */
public class Chat {
    private MessageProducer producer;
    private String url = ActiveMQConnection.DEFAULT_BROKER_URL;

    private static String subject = "CHAT";
    private JTextArea textArea;
    private Session session;
    private String Usuario;
    private JButton btnEnviar;
    private JTextField txtMsg;
    
    public Chat(JTextField msg, JTextArea txtArea, String usuario, JButton btnEnviar) throws JMSException {
        this.textArea = txtArea;
        this.Usuario = usuario;
        this.btnEnviar = btnEnviar;
        this.txtMsg = msg;
        /*JFrame frame = new JFrame("chat");
        textArea = new JTextArea(15, 30);
        JScrollPane scrollPane = new JScrollPane(textArea);
        frame.getContentPane().add(scrollPane, BorderLayout.CENTER);

        textField = new JTextField(30);
        frame.getContentPane().add(textField, BorderLayout.SOUTH);

        textFieldNombre = new JTextField(30);
        frame.getContentPane().add(textFieldNombre, BorderLayout.NORTH);

        frame.pack();
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.setVisible(true);
        */

        btnEnviar.addActionListener(new ActionListener() {

            @Override
            public void actionPerformed(ActionEvent e) {
                MapMessage map;
                try {
                    map = session.createMapMessage();
                    map.setString("usuario", usuario);
                    map.setString("texto", txtMsg.getText());
                    txtMsg.setText("");
                    producer.send(map);
                    producer.setDeliveryMode(DeliveryMode.PERSISTENT);
                    System.out.println(map);

                } catch (JMSException e1) {
                    e1.printStackTrace();
                }
            }
        });

    //activeMQ();
    }
    
}
