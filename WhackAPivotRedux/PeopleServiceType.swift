protocol PeopleServiceType {
func getPeople(success: @escaping ([Person]) -> Void, failure: @escaping (Error) -> Void)
}
