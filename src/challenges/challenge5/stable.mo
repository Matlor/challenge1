import Debug "mo:base/Debug";
import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Hash "mo:base/Hash";
import Cycles "mo:base/ExperimentalCycles";
import Nat "mo:base/Nat";
import Array "mo:base/Array";
import Iter "mo:base/Iter";





actor {

    public shared(msg) func is_anonymous(): async Bool {
        if(Principal.toText(msg.caller)=="2vxsx-fae"){
            return true;
        } else{
            return false;
        }
    };


    // favorite number

    var favoriteNumber: HashMap.HashMap<Principal, Nat> = HashMap.HashMap<Principal, Nat>(10, Principal.equal, Principal.hash);

    public shared(msg) func add_favorite_number(n:Nat): async Text{
        let optNumber: ?Nat = favoriteNumber.get(msg.caller);
        switch(optNumber){
            case(null){
                favoriteNumber.put(msg.caller, n);
                return "You've successfully registered your number";
            };
            case(?v){
                return "You've already registered your number";
            };
        };
    };


    public shared(msg) func show_favorite_number(): async ?Nat {
        favoriteNumber.get(msg.caller);
    };

      
    public shared(msg) func update_favorite_number(n:Nat): async Text{
        let optNumber: ?Nat = favoriteNumber.get(msg.caller);
        switch(optNumber){
            case(null){
                return "You have not yet registered any number";
            };
            case(?v){
                favoriteNumber.put(msg.caller, n);
                return "You've successfully updated your number";
            };
        };
    };

    public shared(msg) func delete_favorite_number(): async () {
        favoriteNumber.delete(msg.caller);
    };


    public shared(msg) func deposit_cycles(): async Nat {
        let received = Cycles.accept(Cycles.available());
    };

    // to do
    public func withdraw_cycles(): async () {};  


    // ------------------ Counter ------------------


    stable var counter: Nat = 0;
    stable var version_number: Nat = 0;


    public func increment_counter(n : Nat) : async Nat {
        counter+= n;
        return counter;
    };

    public func clear_counter() : async Nat {
        counter:=0;
        return counter;
    };

    public func show_version_number(): async Nat{
        return version_number;
    };
   
    stable var favoriteNumberArray: [(Principal, Nat)]= [];

    system func preupgrade() {
        favoriteNumberArray := Iter.toArray(favoriteNumber.entries());

        version_number+=1;
    }; 

    system func postupgrade() {

        favoriteNumber:= HashMap.fromIter(Iter.fromArray(favoriteNumberArray), 10, Principal.equal, Principal.hash);     

    }; 


};


