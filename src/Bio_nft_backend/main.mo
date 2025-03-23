import Nat "mo:base/Nat";
import Text "mo:base/Text";
import List "mo:base/List";
import HashMap "mo:base/HashMap";
import Hash "mo:base/Hash";

// Definición del actor principal
actor {

  // Tipo de un árbol
  type Arbol = {
    arbol_id: Nat;
    name: Text;
    cantidad_arboles: Nat;
  };

  // Lista de árboles (usando List en vez de [])
  var catalogo : List.List<Arbol> = List.nil<Arbol>();

  // Función para agregar un árbol al catálogo
  public func agregarArbol(arbol: Arbol): async Text {
    catalogo := List.push(arbol, catalogo);
    return "Árbol agregado con éxito.";
  };

  // Devuelve todos los árboles como array (para Candid UI)
  public func obtenerCatalogo(): async [Arbol] {
    return List.toArray(catalogo);
  };

  // Devuelve el total de árboles (cantidad en la lista)
  public func calculateTotal(lista: List.List<Arbol>): async Nat {
    return List.size(lista);
  };

  // Simula una adopción: calcula cuántos árboles quedan y el total de adoptados
  public func update(lista: List.List<Arbol>, arboles_adoptados: Nat): async (Nat, Nat) {
    let total = List.size(lista);
    let restantes = total - arboles_adoptados;
    return (total * arboles_adoptados, restantes);
  };

  // Tipo de un adoptador
  type AdoptadorUsuario = {
    adoptador_id: Nat;
    name: Text;
    email: Text;
  };

  // Mapa para registrar adoptadores (clave: ID)
  let adoptador_map = HashMap.HashMap<Nat, AdoptadorUsuario>(0, Nat.equal, Hash.hash);

  // Crear un nuevo adoptador
  public func createAdoptador(adoptador: AdoptadorUsuario): async Text {
    adoptador_map.put(adoptador.adoptador_id, adoptador);
    return "Adoptador registrado.";
  };

};
