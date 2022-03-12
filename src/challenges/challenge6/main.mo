import Hash "mo:base/Hash";
import HashMap "mo:base/HashMap";
import Nat "mo:base/Nat";
import Principal "mo:base/Principal";
import Result "mo:base/Result";
import List "mo:base/List";
import Iter "mo:base/Iter";
import HTTP "./http";
import Text "mo:base/Text";


actor {

    type TokenIndex = Nat;

    // tags
    type Error =  {
        #Type1;
        #Type2;
    };


    func compare(n:TokenIndex, m:TokenIndex): Bool{
        if(n==m){
            return true;
        } else {return false;}
    };

    var registry: HashMap.HashMap<TokenIndex, Principal> = HashMap.HashMap<TokenIndex, Principal>(10, compare, Hash.hash);

    var nextTokenIndex: Nat = 0;


    public shared(msg) func mint(): async Result.Result<(), Text>{
        if(Principal.toText(msg.caller)=="2vxsx-fae"){
            return #err("you need to be authenticated");
        } else {
            registry.put(nextTokenIndex, msg.caller);
            nextTokenIndex+=1;
            #ok;
        };
    };

    public shared(msg) func transfer(to:Principal, tokenIndex:Nat): async Result.Result<(), Text>{
       let isOnwer = registry.get(tokenIndex);
       let caller = msg.caller;
       switch(isOnwer){
            case(null){
               return #err("this token does not exist");
            };
            case(?v){
                if(v==msg.caller){
                    return #ok;
                } else {
                    return #err("this is not your token");
                };
            };
       };
    };


    // go through it, only take entries where match
    // go through List.List<TokenIndex>
    public shared(msg) func balance(): async List.List<TokenIndex> {         
        let iter: Iter.Iter<(TokenIndex, Principal)> = registry.entries();
        let filteredIter: Iter.Iter<(TokenIndex, Principal)> = Iter.filter(iter, func(item: (TokenIndex, Principal)): Bool{
            if(item.1 == msg.caller){
                return true;
            } else {
                return false;
            };
        });
        let onlyIndexIter: Iter.Iter<TokenIndex> = Iter.map<(TokenIndex, Principal),TokenIndex>(filteredIter, func onlyIndex(item: (TokenIndex, Principal) ) : TokenIndex{
            return item.0;
        });
        Iter.toList(onlyIndexIter);
    };

    
    public query func http_request(request : HTTP.Request) : async HTTP.Response {
        let latestMiner: ?Principal = registry.get(nextTokenIndex);
        var latestMinerText : Text = "";
        switch(latestMiner){
            case(null){

            };
            case(?v){
                latestMinerText := Principal.toText(v);
            };
        };
        // Text.encodeUtf8("Hello world" #index # latestMinerText);
        let index = Nat.toText(nextTokenIndex);
        let response = {
            body = Text.encodeUtf8("<html><body><div><h1>Sarah</h1></div></body></html>");
            headers = [("Content-Type", "text/html; charset=UTF-8")];
            status_code = 200 : Nat16;
            streaming_strategy = null
        };
        return(response)
    };


    stable var registryArray: [(TokenIndex, Principal)] = [];

    system func preupgrade() {
        registryArray := Iter.toArray(registry.entries());

    }; 

    system func postupgrade() {
        registry:= HashMap.fromIter(Iter.fromArray(registryArray), 10, Nat.equal, Hash.hash);     
    }; 

    


};