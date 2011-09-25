/**
 * SenseWorldDataNetwork Processing library example.
 *
 * Part of Sense/Stage 
 * http://sensestage.hexagram.ca
 *
 * example by Vincent de Belleval (v@debelleval.com)
 *
 * Please look through the reference folder for all specifics about the client
 */

import datanetwork.*;	//import the datanetwork pacakage
import datanetwork.javaosc.*;	//required for dnEvent(OSCMessages message)

DNConnection dn;	//DNConnection
DNNode node;	//DNNode


void setup() {
	size(200, 200);

	//Create a DNConnection.  Parameters are IP, outgoing port, incoming port, client name.
	dn = new DNConnection(this, "127.0.0.1", dn.getServerPort("127.0.0.1"), 6008, "p5Client");
	dn.setVerbo(4);	//set the verbosity to receive all messages but server pings.
	dn.register();	//register the client on the network.  Can be done anytime.

        //Create a DNNode.  Parameters are NodeId, number of slots, type, node name.
        //type: data type the node is expecting.  0 is float, 1 is String.
        node = new DNNode(2001, 1, 0, "p5NodeToBee");
	dn.addExpected(node);
}

// a variable to set the background color:
float bgred = 0;

void draw() {
	background( bgred, 0, 0);
}

// map our datanode (2001) to a minibee (1) on mouseclick
void mouseClicked() {
  dn.minibeeMap( 2001, 1 );
//   println("subscribed to" + dn.subscribtion_list ); 
}

//setting the node's data with the mouse posisiton.
void mouseMoved() {
	if(dn.isRegistered()) {	//nothing until client is registered and node is supposed to be set on the server.
		float[] mousePostion = {mouseX};	//store mouse position coordinates.
                bgred = mouseX;
		dn.setData(node	, mousePostion);	//set the mousePosition array on our node.
	}
}


/**
 * Always close the DNConnection.  
 * It's optional to remove all the nodes created by the client but the sever currently will not recognize the client 
 * as the setter of its nodes if the client is launched again.
 */
void stop() {
  dn.unsubscribeAll();
  dn.close();	//unregisters the client and closes every port and connection.
}

