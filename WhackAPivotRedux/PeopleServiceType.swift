import Foundation

protocol PeopleServiceType {
    var url: URL? { get set }
    var token: String? { get set }
    var filter: (Person) -> Bool { get set }
    var dispatch: DispatchType { get set }
    func getPeople(success: @escaping ([Person]) -> Void, failure: @escaping (Error) -> Void, filter: @escaping (Person) -> Bool)
}
