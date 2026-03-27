public class PropertyController {

    @InvocableMethod(
        label='Fetch Properties By City'
        description='Returns properties matching the given city name'
    )
    public static List<GetPropertiesByCityResponse> fetchPropertiesByCityName(
        List<GetPropertiesByCityRequest> requests
    ) {
        String cityName = requests[0].input.cityName;

        List<Property__c> properties = [
            SELECT Id, Name, City__c, Property_Category__c,
                   Property_Sub_Category__c, Status__c, State__c
            FROM Property__c
            WHERE City__c = :cityName
            LIMIT 50
        ];

        List<PropertyItem> items = new List<PropertyItem>();
        for (Property__c prop : properties) {
            PropertyItem item = new PropertyItem();
            item.id = prop.Id;
            item.propertyName = prop.Name;
            item.city = prop.City__c;
            item.propertyCategory = prop.Property_Category__c;
            item.propertySubCategory = prop.Property_Sub_Category__c;
            item.status = prop.Status__c;
            item.state = prop.State__c;
            items.add(item);
        }

        PropertiesDataWrapper wrapper = new PropertiesDataWrapper();
        wrapper.items = items;
        wrapper.totalCount = items.size();
        wrapper.summaryMessage = items.isEmpty()
            ? 'No properties found in ' + cityName + '.'
            : 'Found ' + items.size() + ' properties in ' + cityName + '.';

        GetPropertiesByCityResponse response = new GetPropertiesByCityResponse();
        response.dataContainer = wrapper;

        return new List<GetPropertiesByCityResponse>{ response };
    }

    // ── Request wrapper ──
    public class GetPropertiesByCityRequest {
        @InvocableVariable(label='City Name' required=true)
        public PropertyRequestInput input;
    }

    // ── Response wrapper ──
    public class GetPropertiesByCityResponse {
        @InvocableVariable(label='Properties Result')
        public PropertiesDataWrapper dataContainer;
    }

    // ── Input type ──
    public class PropertyRequestInput {
        @InvocableVariable(label='City Name')
        public String cityName;
    }

    // ── Data container — Lightning Type schema points to this class ──
    public class PropertiesDataWrapper {
        public List<PropertyItem> items;
        public Integer totalCount;
        public String summaryMessage;
    }

    // ── Individual property item ──
    public class PropertyItem {
        public String id;
        public String propertyName;
        public String city;
        public String propertyCategory;
        public String propertySubCategory;
        public String status;
        public String state;
    }
}
