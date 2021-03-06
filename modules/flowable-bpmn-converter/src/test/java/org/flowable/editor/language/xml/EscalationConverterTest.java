/* Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.flowable.editor.language.xml;

import static org.assertj.core.api.Assertions.assertThat;

import java.util.Collection;

import org.flowable.bpmn.model.BpmnModel;
import org.flowable.bpmn.model.Escalation;
import org.junit.jupiter.api.Test;

public class EscalationConverterTest extends AbstractConverterTest {

    @Test
    public void convertXMLToModel() throws Exception {
        BpmnModel bpmnModel = readXMLFile();
        validateModel(bpmnModel);
    }

    @Test
    public void convertModelToXML() throws Exception {
        BpmnModel bpmnModel = readXMLFile();
        BpmnModel parsedModel = exportAndReadXMLFile(bpmnModel);
        validateModel(parsedModel);
    }

    private void validateModel(BpmnModel model) {
        Collection<Escalation> escalations = model.getEscalations();
        assertThat(escalations).hasSize(2);
        assertThat(model.getEscalation("escalation1").getEscalationCode()).isEqualTo("firstEscalation");
        assertThat(model.getEscalation("escalation1").getName()).isEqualTo("Escalation 1");
        assertThat(model.getEscalation("escalation2").getEscalationCode()).isEqualTo("secondEscalation");
        assertThat(model.getEscalation("escalation2").getName()).isEqualTo("Escalation 2");
    }

    @Override
    protected String getResource() {
        return "escalationtest.bpmn";
    }
}
