/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ChatActive;

import Conexion.Conexion;
import java.awt.BorderLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.sql.CallableStatement;
import java.sql.Types;
import javax.jms.Connection;
import javax.jms.ConnectionFactory;
import javax.jms.DeliveryMode;
import javax.jms.Destination;
import javax.jms.JMSException;
import javax.jms.MapMessage;
import javax.jms.Message;
import javax.jms.MessageConsumer;
import javax.jms.MessageListener;
import javax.jms.MessageProducer;
import javax.jms.Session;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JScrollPane;
import javax.swing.JTextArea;
import javax.swing.JTextField;
import org.apache.activemq.ActiveMQConnection;
import org.apache.activemq.ActiveMQConnectionFactory;

/**
 *
 * @author Angel
 */
public class Chat {
    private MessageProducer producer;
    //private static final String URL = "tcp://192.168.1.13:61616";
    //private String url = ActiveMQConnection.DEFAULT_BROKER_URL;
    private static final String URL = "tcp://localhost:61616";
    private static final String USER = ActiveMQConnection.DEFAULT_USER;
    private static final String PASSWORD = ActiveMQConnection.DEFAULT_PASSWORD;

    private static String Sala;
    private JTextArea textArea;
    private Session session;
    private String Usuario;
    private JButton btnEnviar;
    private JTextField txtMsg;
    private int IDRom;
    
    private Connection connection;
    
    public Chat(JTextField msg, JTextArea txtArea, String usuario, JButton btnEnviar,String nombreSala, int idrom) throws JMSException {
        this.textArea = txtArea;
        this.Usuario = usuario;
        this.btnEnviar = btnEnviar;
        this.txtMsg = msg;
        this.Sala = nombreSala;
        this.IDRom = idrom;
        System.out.println(nombreSala);
        btnEnviar.addActionListener(new ActionListener() {

            @Override
            public void actionPerformed(ActionEvent e) {
                MapMessage map;
                try {
                    System.out.println(usuario);
                    System.out.println(txtMsg.getText());
                    System.out.println(idrom);
                    
                    map = session.createMapMessage();
                    map.setString("usuario", usuario);
                    map.setString("texto", txtMsg.getText());
                    //txtMsg.setText("");
                    producer.send(map);
                    producer.setDeliveryMode(DeliveryMode.PERSISTENT);
                    System.out.println(map);

                } catch (JMSException e1) {
                    e1.printStackTrace();
                }
            }
        });

        activeMQ();
    }
    
    
    private void activeMQ() throws JMSException {
        ConnectionFactory connectionFactory = new ActiveMQConnectionFactory(USER,PASSWORD,URL);
        connection = connectionFactory.createConnection();
        connection.start();
        session = connection.createSession(false, Session.AUTO_ACKNOWLEDGE);

        // Destination represents here our queue 'TESTQUEUE' on the
        // JMS server. You don't have to do anything special on the
        // server to create it, it will be created automatically.
        Destination destination = session.createTopic(Sala);

        producer = session.createProducer(destination);

        MessageConsumer consumer = session.createConsumer(destination);
        consumer.setMessageListener(new MessageListener() {

            @Override
            public void onMessage(Message message) {
                if (message instanceof MapMessage) {
                    MapMessage map = (MapMessage) message;
                    try {
                        String usuario = map.getString("usuario");
                        String texto = map.getString("texto");
                        textArea.append(usuario.toUpperCase() + ": " + texto + "\n");
                    } catch (JMSException e) {
                        e.printStackTrace();
                    }
                }

            }
        });
    }

    public Connection getConnection() {
        return connection;
    }

    public void setConnection(Connection connection) {
        this.connection = connection;
    }
    
    public void stopConecction() throws JMSException{
        connection.close();
    }
}
