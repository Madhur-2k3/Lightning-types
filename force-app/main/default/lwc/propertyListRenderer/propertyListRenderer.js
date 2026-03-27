import { LightningElement, api } from 'lwc';

export default class PropertyListRenderer extends LightningElement {
    // Agentforce automatically injects your data into this property
    @api value;

    get items() {
        return this.value?.items || [];
    }

    get totalCount() {
        return this.value?.totalCount || 0;
    }

    get summaryMessage() {
        return this.value?.summaryMessage || '';
    }

    get hasData() {
        return (this.items?.length || 0) > 0;
    }

    get noData() {
        return !this.hasData;
    }
}
