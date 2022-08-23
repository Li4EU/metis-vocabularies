<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:gvp="http://vocab.getty.edu/ontology#"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:skos="http://www.w3.org/2004/02/skos/core#"
    xmlns:edm="http://www.europeana.eu/schemas/edm/"
    xmlns:AdminPlaceConcept="http://vocab.getty.edu/ontology#">
    <xsl:param name="targetId"/>
    <xsl:output indent="yes" encoding="UTF-8"/>
    <xsl:template match="/rdf:RDF">
        <!-- Parent mapping: gvp:Subject -> edm:Place -->
        <xsl:for-each select="./AdminPlaceConcept:Subject">
            <xsl:if test="@rdf:about = $targetId">
                <edm:Place>
                    <!-- Attribute mapping: rdf:about -> rdf:about -->
                    <xsl:if test="@rdf:about">
                        <xsl:attribute name="rdf:about">
                            <xsl:value-of select="@rdf:about"/>
                        </xsl:attribute>
                    </xsl:if>
                    <!-- Tag mapping: skos:prefLabel -> skos:prefLabel -->
                    <xsl:for-each select="./skos:prefLabel">
                        <skos:prefLabel>
                            <!-- Text content mapping (only content with non-space characters) -->
                            <xsl:for-each select="text()[normalize-space()]">
                                <xsl:if test="position() &gt; 1">
                                    <xsl:text> </xsl:text>
                                </xsl:if>
                                <xsl:value-of select="normalize-space(.)"/>
                            </xsl:for-each>
                        </skos:prefLabel>
                    </xsl:for-each>
                </edm:Place>
            </xsl:if>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>
