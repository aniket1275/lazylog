use backend::health_status;

#[test]
fn test_health_status() {
    assert_eq!(health_status(), "healthy");
}