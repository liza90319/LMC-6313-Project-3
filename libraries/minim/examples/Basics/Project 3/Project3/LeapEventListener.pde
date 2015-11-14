class LeapEventListener extends Listener {
    void onFrame (Controller controller){
        System.out.println("New Frame");
    }

    void onInit (Controller controller){
        System.out.println("Initialized");
    }

    void onConnect (Controller controller){
        System.out.println("Connected");
    }

    void onDisconnect (Controller controller){
        System.out.println("Disconnected");
    }

    /*void onFocusGained (Controller controller){
        System.out.println("Focus gained");
    }*/

    /*void  onFocusLost (Controller controller){
        System.out.println("Focus lost");        
    }*/
}